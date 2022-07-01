<template>
  <div class="main-in">
    <div class="chat">
      <div class="chat-content">
        <div class="chat-main--wrapper">
          <div class="chat-main" id="chat-main">
            <template v-for="(msg, index) in messages" >
              <div v-if="!index || getDateString(messages[index-1].created_at) != getDateString(msg.created_at)" class="chat-date">{{ msg.created_at | formatDateWithDay }}</div>
              <div :class="{'other': !msg.is_mine, 'me': msg.is_mine }">
                <p class="avatar"><img src="/img/img.svg" width="45px"></p>
                <div>
                  <div>
                    <p v-if="!msg.is_file" class="message">{{ msg.message }}
                      <span v-if="messages.length == 1" class="chat-time">{{ msg.display_time_lable }}</span>
                      <span v-else-if="(index + 1) < messages.length && msg.display_time_lable != messages[index+1].display_time_lable" class="chat-time">{{ msg.display_time_lable }}</span>
                      <!-- <span v-else-if="(index) == (messages.length-1) && msg.display_time_lable != messages[index-1].display_time_lable" class="chat-time">{{ msg.display_time_lable }}</span> -->
                      <span v-else-if="(index) == (messages.length-1)" class="chat-time">{{ msg.display_time_lable }}</span>
                    </p>
                    <div v-else class="message--file">
                      <img :src="msg.message" @click="handleShowImageFullscreen(msg.message.replace('/thumbs', ''))" />
                      <!-- <span v-if="!index || getUnixTimestamp(msg.created_at) - getUnixTimestamp(messages[index-1].created_at) > 60" class="chat-time">{{ msg.created_at | formatTime12 }}</span> -->
                    </div>
                  </div>
                </div>
              </div>
            </template>
          </div>
        </div>
        <div class="chat-input">
          <file-upload
            v-if="mailboxId"
            ref="messageFileUploadComponent"
            id="attachment-dropzone"
            :maxFiles="5"
            :uploadUrl="`/api/clinic/mailboxes/${this.mailboxId}/fileupload`"
            :chat="true"
            @file-upload-success="handleFileSaved"
            @queue-complete="handleMultiFilesQueueComplete"
          />
          <textarea
            v-if="reservation"
            :placeholder="`${reservation.patient? reservation.patient.kana : ''}さんにメッセージを書く`"
            v-model="newMessage" ></textarea>
          <button class="message-send" @click="handleSendMessage">{{ $t('送信') }}</button>
        </div>
      </div>
      <div v-if="reservation" class="chat-user">
        <p class="chat-user-name">予約内容</p>
          <div class="chat-user-profile">
            <ul>
              <li>
                <p><span>{{ $t('名前') }}</span></p>
                <p class="hiragana">{{ reservation.patient? reservation.patient.kana : '' }}</p>
              </li>
              <li>
                <p><span>{{ $t('生年月日') }}</span></p>
                <p>{{ reservation.patient? reservation.patient.birthday : '' | formatDate }}{{ reservation.patient? reservation.patient.age : '' }}歳</p>
              </li>
              <li>
                <p><span>{{ $t('性別') }}</span></p>
                <p>{{reservation.patient? reservation.patient.gender : '' && gender_types[reservation.patient? reservation.patient.gender : '']}}</p>
              </li>
              <li>
                <p><span>{{ $t('電話番号') }}</span></p>
                <p>{{ reservation.patient? reservation.patient.phone_number : '' }}</p>
              </li>
              <li>
                <p><span>{{ $t('希望ドクター') }}</span></p>
                <p v-if="reservation.doctor">{{ reservation.doctor.kata_name }}</p>
                <p v-else></p>
              </li>
              <li>
                <p><span>{{ $t('当日の施術について') }}</span></p>
                <p>{{ hope_treat_types[reservation.hope_treat] }}</p>
              </li>
              <li>
                <p><span>{{ $t('相談したいこと') }}</span></p>
                <p>{{ reservation.note }}</p>
              </li>
              <li>
                <p><span>{{ $t('来院希望日時') }}</span></p>
                <div v-for="(hope_time, index) in reservation.hope_times" :key="hope_time.id">
                  <p>第{{ index + 1 }}希望</p>
                  <p>{{ hope_time.start_time_str }}</p>
                </div>
              </li>
            </ul>
          </div>
        <div class="item-center">
            <button v-if="reservation.status == 5" class="btn btn-chat-confirm" @click="showRsvModal()">日時を確定</button>
            <button class="btn btn-danger" @click="showDelModal()">予約をキャンセル</button>
        </div>
      </div>
    </div>
    <VueEasyLightbox
      :visible="fullscreen"
      :imgs="image"
      :index="0"
      @hide="handleHideImageFullscreen"
    ></VueEasyLightbox>

    <form-modal
      ref="modal"
      :title="$t('予約内容')"
      @cancel="clearRsvModal"
      >
      <div v-if="reservation_form && reservation" class="reserve-content">
        <ul>
          <li>
            <div>{{ $t('診察者') }}</div>
            <div class="rsv-main-content">
              <div>
                <span>{{ $t('名前') }}</span>
                {{ reservation.patient? reservation.patient.kana : '' }}
              </div>
              <div>
                <span>{{ $t('性別') }}</span>
                {{ gender_types[reservation.patient? reservation.patient.gender : ''] }}
              </div>
              <div>
                <span>{{ $t('年齢') }}</span>
                {{ reservation.patient? reservation.patient.age : '' }}
              </div>
              <div>
                <span>{{ $t('生年月日') }}</span>
                {{ reservation.patient? reservation.patient.birthday : '' | formatDate }}
              </div>
              <div>
                <span>{{ $t('電話番号') }}</span>
                  {{ reservation.patient? reservation.patient.phone_number : '' }}
              </div>
            </div>
          </li>
          <li>
            <div>{{ $t('予約日') }}</div>
            <div class="rsv-main-content2">
              <div>
                <span>{{ $t('日にち') }}</span>
                <v-date-picker
                  class="h-auto"
                  v-model="reservation_form.reservations.visit_date"
                  :masks="{ L: 'YYYY-MM-DD' }"
                  :attributes='attrs'
                  :class="{'is-invalid' : errors && errors['reservations.visit_date'] && reservation_form.reservations.visit_date == null}"
                >
                  <template v-slot="{ inputValue, inputEvents }">
                    <input
                      class="px-2 py-1 border rounded focus:outline-none focus:border-blue-300"
                      :value="inputValue"
                      v-on="inputEvents"
                    />
                  </template>
                </v-date-picker>
                <div v-if="errors && errors['reservations.visit_date']" class="error invalid-feedback">{{ errors['reservations.visit_date'][0] }}</div>
              </div>
              <div class="time-picker-content">
                <span>{{ $t('診断時間') }}</span>
                <vue-timepicker fixed-dropdown-button placeholder=" " v-model="timePicker_start_time" :class="{'is-invalid' : errors && errors['reservations.start_time'] && (timePicker_start_time.HH == '' || timePicker_start_time.mm == '')}" :hour-range="[[6, 23]]" :minute-interval="15"></vue-timepicker>
                <div v-if="errors && errors['reservations.start_time']" class="error invalid-feedback">{{ errors['reservations.start_time'][0] }}</div>
              </div>
            </div>
          </li>
          <li>
            <div>{{ $t('担当者') }}</div>
            <div class="rsv-main-content2">
              <div>
                <span>{{ $t('医師') }}</span>
                <!-- <select v-model="reservation_form.reservations.doctor_id" :class="{'is-invalid' : errors && errors['reservations.doctor_id'] }">
                  <option></option>
                  <option v-for="(doctor) in doctors" :key="doctor.id" :value="doctor.id">{{ doctor.kata_name }}</option>
                </select> -->
                <c-select
                  :options="doctors"
                  :textkey="'kata_name'"
                  :valkey="'id'"
                  :emptyable="true"
                  :default="reservation_form.reservations.doctor_id"
                  class="select"
                  ref="doctorSelect"
                  @change="selectedDoctor"
                  :class="{'is-invalid' : errors && errors['reservations.doctor_id'] && reservation_form.reservations.doctor_id == null}"
                />
                <div v-if="errors && errors['reservations.doctor_id']" class="error invalid-feedback">{{ errors['reservations.doctor_id'][0] }}</div>
              </div>
              <div>
                <span>{{ $t('予約内容') }}</span>
                <!-- <select v-model="reservation_form.reservations.hope_treat" :class="{'is-invalid' : errors && errors['reservations.hope_treat'] }">
                  <option></option>
                  <option v-for="(name, id) in hope_treat_types" :key="id" :value="id">{{ name }}</option>
                </select> -->
                <c-enum-select
                  :options="hope_treat_types"
                  :emptyable="true"
                  :default="reservation_form.reservations.hope_treat"
                  class="select"
                  ref="hopeTreatSelect"
                  @change="selectedHopeTreat"
                  :class="{'is-invalid' : errors && errors['reservations.hope_treat'] && reservation_form.reservations.hope_treat == null}"
                />
                <div v-if="errors && errors['reservations.hope_treat']" class="error invalid-feedback">{{ errors['reservations.hope_treat'][0] }}</div>
              </div>
            </div>
          </li>
        </ul>
      </div>
      <div class="btn-wrapper">
        <button type="button" class="btn btn-primary" @click="handleConfirmRsv">{{ $t('予約を確定する') }}</button>
      </div>
    </form-modal>
    <form-modal
        ref="delModal"
        id="del-modal"
        :title="delModalInfo.title"
        >
          <div class="main-modal">
            <div class="auth--wrapper">
              <div class="auth-form">
                <h2 class="auth-title" >
                  {{ $t('予約情報を削除しますか？') }}
                </h2>
                <div class="auth-title-tip">
                  <template>
                    予約情報を削除してよろしいでしょうか？<br>
                    削除すると復元することはできません。
                  </template>
                </div>
              </div>
              <div class="btn-grp">
                <button type="button" class="btn btn-cancel" @click="cancelModal()">キャンセル</button>
                <button type="button" class="btn btn-danger" @click="cancelReservation()">削除する</button>
              </div>
            </div>
          </div>
      </form-modal>
  </div>
</template>

<script>
import axios from 'axios'
import { mapGetters } from 'vuex'
import VueEasyLightbox from 'vue-easy-lightbox'

export default {
  middleware: 'auth',

  data() {
    return {
        messages: [],
        doctors: [],
        mailboxId: undefined,
        reservation: undefined,
        form: {
            messages: {
            message: '',
            },
            files: [],
        },
        reservation_form: undefined,
        newMessage: '',
        newMessages: [],
        isSedning: false,
        lastMessage: undefined,
        lastMessageId: undefined,
        fullscreen: false,
        image: '',
        errors: undefined,
        attrs: [
          {
            key: 'today',
            highlight: {
              color: 'gray',
              fillMode: 'light',
            },
            dates: new Date(),
          },
        ],
        delModalInfo: {
          title: '',
          confirmBtnTitle: '',
        },
        timePicker_start_time: {
          HH: '',
          mm: ''
        },
    }
  },

  components: {
    VueEasyLightbox
  },

  computed: {
    ...mapGetters({
      user: 'auth/user',
      gender_types: 'constant/gender_types',
      hope_treat_types: 'constant/hope_treat_types',
    }),
  },

  mounted() {
    this.mailboxId = this.$route.params.id;
    // this.registerSnapshot()
    this.$store.dispatch('state/setIsLoading')

    return Promise.all([
        axios.get(`/api/clinic/mailboxes/${this.mailboxId}/reservation`),
        axios.get(`/api/clinic/mailboxes/${this.mailboxId}/messages`),
        axios.get(`/api/clinic/mailboxes/common_data`),
      ]).then(([res1, res2, res3]) => {
        this.reservation = res1.data.reservation
        this.messages = res2.data.messages
        this.doctors = res3.data.doctors;

        this.$nextTick(() => this.scrollToEnd());
      }).finally(() => {
        this.$store.dispatch('state/removeIsLoading')
      });
  },

  methods: {
    showRsvModal() {
      this.errors = {}
      this.reservation_form = {
        reservations: {
          visit_date: this.reservation.visit_date,
          start_time: this.reservation.start_time,
          end_time: this.reservation.end_time,
          doctor_id: this.reservation.doctor_id,
          hope_treat: this.reservation.hope_treat,
        }
      }

      if(this.reservation_form.reservations.start_time != null) {
        var arr = this.reservation_form.reservations.start_time.split(':');
        this.timePicker_start_time.HH = arr[0];
        this.timePicker_start_time.mm = arr[1];
      }

      if(this.$refs.doctorSelect) this.$refs.doctorSelect.set(this.reservation_form.reservations.doctor_id);
      if(this.$refs.hopeTreatSelect) this.$refs.hopeTreatSelect.set(this.reservation_form.reservations.hope_treat);
      this.$refs.modal.show()
    },

    showDelModal() {
      this.$refs.delModal.show()
    },

    clearRsvModal() {
      // this.$refs.doctorSelect.clear();
      this.$refs.doctorSelect.clear();
      this.$refs.hopeTreatSelect.clear();

      this.errors = undefined;
      // this.reservation = undefined;
      this.reservation_form = undefined;
      this.timePicker_start_time = {
        HH: '',
        mm: ''
      }

      // this.$refs.modal.hide();
    },

    cancelModal(){
      this.$refs.delModal.hide()
    },
    scrollToEnd() {
      setTimeout(() => {
        var container = this.$el.querySelector("#chat-main");
        container.scrollBy({
          top: container.scrollHeight, // could be negative value
          left: 0,
          behavior: 'smooth'
        });
      }, 500)
    },

    // handleChangeStatus(newStatus) {
    //   this.$swal({
    //     title: '本当に変更しますか？',
    //     icon: 'warning',
    //     showCancelButton: true,
    //   }).then((result) => {
    //     if (result.value) {
    //       this.$store.dispatch('state/setIsLoading')
    //       axios.get(`/api/clinic/reservations/${this.reservation.id}/status/${newStatus}`)
    //         .then(res => {
    //           this.reservation = res.data.reservation
    //           this.$swal({
    //             toast: true,
    //             position: 'top-end',
    //             showConfirmButton: false,
    //             timer: 3000,
    //             title: '変更しました。',
    //             icon: 'success',
    //           })
    //           this.$store.dispatch('state/removeIsLoading')
    //         })
    //         .catch(error => {
    //           this.$swal({
    //             toast: true,
    //             position: 'top-end',
    //             showConfirmButton: false,
    //             timer: 3000,
    //             title: '変更できません。',
    //             icon: 'error',
    //           })
    //           this.$store.dispatch('state/removeIsLoading')
    //         })
    //     }
    //   })
    // },

    handleSendMessage(e) {
      let fileCount = this.$refs.messageFileUploadComponent.getQueuedFiles()
      if (fileCount) {
        this.$refs.messageFileUploadComponent.processQueue();
      } else {
        this.sendMessage(this.newMessage)
        this.newMessage = ''
      }

      this.$nextTick(() => this.scrollToEnd());
    },

    handleSendFile() {
      this.$refs.messageFileUploadComponent.processQueue();
    },

    sendMessage(message, isFile = 0) {
        if (!message) return;

        this.newMessages.push({
            message: message,
            isFile: isFile
        })

        if (this.isSedning === false) {
            this.isSending = true;
            this.sendToTarget();
        }
    },

    sendToTarget() {
        if (this.newMessages.length === 0) {
            this.isSending = false;
            return;
        }
        let sendingMessage = this.newMessages[0];
        this.newMessages = this.newMessages.filter((item, index) => index > 0);

        let formMessage = {
            messages: {
                message: sendingMessage.message,
                is_file: sendingMessage.isFile,
            }
        }

        axios.post(`/api/clinic/mailboxes/${this.mailboxId}/messages`, formMessage)
            .then(res => {
                this.messages.push(res.data.message)
                let pushMessage = {
                    message: {
                        mailbox_id: res.data.message.mailbox_id,
                        user_id: res.data.message.user_id,
                        message: res.data.message.message,
                        is_file: res.data.message.is_file,
                        is_mine: !res.data.message.is_mine,
                        created_at: res.data.message.created_at,
                    }
                }

                // this.updateFirebase(this.reservation.patient_info.firebase_key, pushMessage)

                this.$forceUpdate();

                let self = this;
                setTimeout(function() {
                    self.sendToTarget()
                }, 500);
        })
    },

    handleFileInput() {
      $('#attachment-dropzone').trigger('click')
    },

    getDateString(value) {
      if (value) {
        return value.substr(0, 10);
      }
      return value;
    },

    getUnixTimestamp(value) {
      if (value) {
        return this.$moment(value).unix()
      }
      return value;
    },

    handleFileSaved(fileUrl) {
      this.sendMessage(fileUrl, 1)
    },

    handleMultiFilesQueueComplete() {
        this.$refs.messageFileUploadComponent.removeAllFiles()
        if (this.newMessage) {
            this.sendMessage(this.newMessage)
            this.newMessage = ''
        }
    },

    // registerSnapshot() {
    //     if (this.user.firebase_key) {

    //       let self = this;
    //       this.snapShot = firestore.collection("users").doc(this.user.firebase_key)
    //           .onSnapshot(function (docRef) {
    //               let to = docRef.data();
    //               if (!self.lastMessage) {
    //                 self.lastMessage = { ...to.message }
    //               }

    //               if (!to.message) return;

    //               if (self.lastMessage && JSON.stringify(self.lastMessage) !== JSON.stringify(to.message) && parseInt(to.message.mailbox_id) === parseInt(self.mailboxId)) {

    //                   if (to.message.user_id === self.reservation.patient.user_id) {
    //                       self.messages.push({
    //                           is_mine: false,
    //                           message: to.message.message,
    //                           is_file: to.message.is_file,
    //                           file_thumb_url: to.message.is_file && `${to.message.message}`,
    //                           created_at: to.message.created_at,
    //                       })

    //                       self.messages = self.messages.sort((a, b) => {
    //                           if (a.created_at > b.created_at) return 1;
    //                           if (a.created_at < b.created_at) return -1;
    //                           return 0;
    //                       })

    //                       self.lastMessage = { ...to.message }

    //                       self.$forceUpdate()

    //                       self.scrollToEnd()
    //                   }
    //               }
    //         })
    //     }
    // },

    // updateFirebase(key, data) {
    //     if (!key) return;
    //     firestore.collection('users').doc(key)
    //         .update(data)
    // },

    handleShowImageFullscreen(thumnUrl)
    {
        this.image = thumnUrl.replace('/thumbs', '')
        this.fullscreen = true
    },

    handleHideImageFullscreen() {
        this.fullscreen = false
    },

    selectedDoctor(selected_option) {
      this.reservation_form.reservations.doctor_id = selected_option ? selected_option.id : null;
    },

    selectedHopeTreat(selected_option) {
      this.reservation_form.reservations.hope_treat = selected_option;
    },

    handleConfirmRsv() {
      this.$store.dispatch('state/setIsLoading')

      // this.reservation_form.reservations.start_time = this.getTime(this.reservation_form.reservations.start_time);
      // this.reservation_form.reservations.visit_date = (new Date(this.reservation_form.reservations.visit_date)).toISOString().substring(0, 10);

      if (this.timePicker_start_time.HH == '' || this.timePicker_start_time.mm == '')
        this.reservation_form.reservations.start_time = null;
      else
        this.reservation_form.reservations.start_time = this.timePicker_start_time.HH + ':' + this.timePicker_start_time.mm;

      if(this.reservation_form.reservations.visit_date != null)
        this.reservation_form.reservations.visit_date = (new Date(this.reservation_form.reservations.visit_date)).toISOString().substring(0, 10);

      axios.put(`/api/clinic/reservations/${this.reservation.id}`, this.reservation_form)
        .then(res => {
          this.reservation = res.data.reservation

          this.$store.dispatch('state/removeIsLoading')
          this.$refs.modal.hide()
          this.$swal({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            title: '変更しました。',
            icon: 'success',
          })
        })
        .catch(error => {
          this.errors = { ...error.response.data.errors }
          this.$store.dispatch('state/removeIsLoading')
        });
    },

    cancelReservation() {
      this.$store.dispatch('state/setIsLoading')
      axios.delete(`/api/clinic/reservations/delete/${this.reservation.id}`)
      .then(res => {
        // this.$store.dispatch('state/removeIsLoading');
        this.$router.push({name: 'reservations'});
        this.$swal({
          toast: true,
          position: 'top-end',
          showConfirmButton: false,
          timer: 3000,
          title: '削除。',
          icon: 'success',
        })
      })
      .catch(error => {
        this.$store.dispatch('state/removeIsLoading')
      })
    },

    // getTime(time_obj) {
    //   if(time_obj.HH)
    //     return time_obj.HH + ':' + time_obj.mm;
    //   else
    //     return time_obj;
    // },
  },
}
</script>

<style scoped>
  * >>> #del-modal .form-modal-header{
    display: none !important;

  }
  * >>> #del-modal.form-modal-wrapper{
    top: 130px;
    left: 25vw;
    width: 50vw;
    align-items: center;
  }
  #del-modal .main-modal{
    padding: 0;
  }
</style>
