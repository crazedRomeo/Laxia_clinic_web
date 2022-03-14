<template>
  <div class="main-in">
    <div class="chat">
      <div class="chat-content">
        <div class="chat-main--wrapper">
          <div class="chat-main" id="chat-main">
            <template v-for="(msg, index) in messages">
              <div v-if="!index || getDateString(messages[index-1].created_at) != getDateString(msg.created_at)" class="chat-date">{{ msg.created_at | formatDateWithDay }}</div>
              <div :class="{'other': !msg.is_mine, 'me': msg.is_mine }">
                <p class="avatar"><img src="/img/img.svg" width="45px"></p>
                <div>
                  <div>
                    <p v-if="!msg.is_file" class="message">{{ msg.message }}
                      <span v-if="!index || getUnixTimestamp(msg.created_at) - getUnixTimestamp(messages[index-1].created_at) > 60" class="chat-time">{{ msg.created_at | formatTime12 }}</span></p>
                    <div v-else class="message--file">
                      <img :src="msg.message" @click="handleShowImageFullscreen(msg.message.replace('/thumbs', ''))" />
                      <span v-if="!index || getUnixTimestamp(msg.created_at) - getUnixTimestamp(messages[index-1].created_at) > 60" class="chat-time">{{ msg.created_at | formatTime12 }}</span>
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
            :placeholder="`${reservation.patient_info.name01}さんにメッセージを書く`"
            v-model="newMessage" ></textarea>
          <!-- <button class="add-file" @click="handleFileInput"><img src="/img/addFile.svg"></button> -->
          <button class="message-send" @click="handleSendMessage">{{ $t('送信') }}</button>
        </div>
      </div>
      <div v-if="reservation" class="chat-user">
        <!-- <p class="chat-user-img"><img src="/img/img.svg"></p> -->
        <!-- <p class="chat-user-name">{{ reservation.patient_info.name }}</p> -->
        <p class="chat-user-name">予約内容</p>
        <div class="chat-user-profile">
          <ul>
            <li>
              <p><span>{{ $t('名前') }}</span></p>
              <p class="hiragana">{{ reservation.patient_info.kana }}</p>
              <!-- <p>{{ reservation.patient_info.name }}</p> -->
            </li>
            <li>
              <p><span>{{ $t('生年月日') }}</span></p>
              <p>{{ reservation.patient_info.birthday | formatDate }}{{ reservation.patient_info.age }}歳</p>
            </li>
            <li>
              <p><span>{{ $t('性別') }}</span></p>
              <p>{{reservation.patient_info.gender && gender_types[reservation.patient_info.gender]}}</p>
            </li>
            <!-- <li>
              <p><span>{{ $t('年齢') }}</span></p>
              <p>{{ reservation.patient_info.age }}才</p>
            </li> -->
            <li>
              <p><span>{{ $t('電話番号') }}</span></p>
              <p>{{ reservation.patient_info.phone_number }}</p>
            </li>
            <!-- <li>
              <p><span>{{ $t('予約内容') }}</span></p>
              <p>{{ reservation.rsv_content ? reservation.rsv_content.name : '未確定' }}</p>
            </li>
            <li>
              <p><span>{{ $t('診察メニュー') }}</span></p>
              <p>{{ reservation.menu ? reservation.menu.name : '未確定' }}</p>
            </li> -->
            <li>
              <p><span>{{ $t('希望ドクター') }}</span></p>
              <p>西田 仁</p>
            </li>
            <li>
              <p><span>{{ $t('当日の施術について') }}</span></p>
              <p>カウンセリングのみ</p>
            </li>
            <li>
              <p><span>{{ $t('相談したいこと') }}</span></p>
              <p>ニキビ跡や肌荒れで悩んでいます。どういった施術が適していますでしょうか？</p>
            </li>
            <li>
              <p><span>{{ $t('来院希望日時') }}</span></p>
              <p>第1希望</p>
              <p>2021年5月22日(水) 13:30</p>
              <p>第2希望</p>
              <p>2021年5月22日(水) 13:30</p>
              <p>第希望</p>
              <p>2021年5月22日(水) 13:30</p>
            </li>            
          </ul>
          <div class="item-center">
            <button class="btn  btn-chat-confirm">日時を確定</button>
          </div>
          <div class="item-center"> 
            <button class="btn btn-danger">予約をキャンセル</button>
          </div>
          
        </div>
        <!-- <div class="btn-wrapper">
          <button v-if="reservation.status == 5 || reservation.status == 10" class="btn2" @click="handleChangeStatus(15)">{{ $t('調整中') }}</button>
          <button v-if="reservation.status == 15" class="btn" @click="handleChangeStatus(20)">{{ $t('調整完了') }}</button>
        </div> -->
      </div>
    </div>
    <VueEasyLightbox
      :visible="fullscreen"
      :imgs="image"
      :index="0"
      @hide="handleHideImageFullscreen"
    ></VueEasyLightbox>
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
        mailboxId: undefined,
        reservation: undefined,
        form: {
            messages: {
            message: '',
            },
            files: [],
        },
        newMessage: '',
        newMessages: [],
        isSedning: false,
        lastMessage: undefined,
        lastMessageId: undefined,
        fullscreen: false,
        image: '',
    }
  },

  components: {
    VueEasyLightbox
  },

  computed: {
    ...mapGetters({
      user: 'auth/user',
      gender_types: 'constant/gender_types',
    }),
  },

  mounted() {
    this.mailboxId = this.$route.params.id;

    this.registerSnapshot()

    this.$store.dispatch('state/setIsLoading')

    return Promise.all([
        axios.get(`/api/clinic/mailboxes/${this.mailboxId}/reservation`),
        axios.get(`/api/clinic/mailboxes/${this.mailboxId}/messages`)
      ]).then(([res1, res2]) => {
        this.reservation = res1.data.reservation
        this.messages = res2.data.messages

        this.$nextTick(() => this.scrollToEnd());
      }).finally(() => {
        this.$store.dispatch('state/removeIsLoading')
      });
  },

  methods: {
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

    handleChangeStatus(newStatus) {
      this.$swal({
        title: '本当に変更しますか？',
        icon: 'warning',
        showCancelButton: true,
      }).then((result) => {
        if (result.value) {
          this.$store.dispatch('state/setIsLoading')
          axios.get(`/api/clinic/reservations/${this.reservation.id}/status/${newStatus}`)
            .then(res => {
              this.reservation = res.data.reservation
              this.$swal({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000,
                title: '変更しました。',
                icon: 'success',
              })
              this.$store.dispatch('state/removeIsLoading')
            })
            .catch(error => {
              this.$swal({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000,
                title: '変更できません。',
                icon: 'error',
              })
              this.$store.dispatch('state/removeIsLoading')
            })
        }
      })
    },

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

                this.updateFirebase(this.reservation.patient_info.firebase_key, pushMessage)
                
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

    registerSnapshot() {
        if (this.user.firebase_key) {
          
          let self = this;
          this.snapShot = firestore.collection("users").doc(this.user.firebase_key)
              .onSnapshot(function (docRef) {
                  let to = docRef.data();
                  if (!self.lastMessage) {
                    self.lastMessage = { ...to.message }
                  }
                
                  if (!to.message) return;
                
                  if (self.lastMessage && JSON.stringify(self.lastMessage) !== JSON.stringify(to.message) && parseInt(to.message.mailbox_id) === parseInt(self.mailboxId)) {
                      
                      if (to.message.user_id === self.reservation.patient_info.user_id) {
                          self.messages.push({
                              is_mine: false,
                              message: to.message.message,
                              is_file: to.message.is_file,
                              file_thumb_url: to.message.is_file && `${to.message.message}`,
                              created_at: to.message.created_at,
                          })

                          self.messages = self.messages.sort((a, b) => {
                              if (a.created_at > b.created_at) return 1;
                              if (a.created_at < b.created_at) return -1;
                              return 0;
                          })

                          self.lastMessage = { ...to.message }

                          self.$forceUpdate()
                          
                          self.scrollToEnd()
                      }
                  }
            })
        }
    },

    updateFirebase(key, data) {
        if (!key) return;
        firestore.collection('users').doc(key)
            .update(data)
    },

    handleShowImageFullscreen(thumnUrl)
    {
        this.image = thumnUrl.replace('/thumbs', '')
        this.fullscreen = true
    },

    handleHideImageFullscreen() {
        this.fullscreen = false
    }
  },
}
</script>

<style scoped>
</style>
