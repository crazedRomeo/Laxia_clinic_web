<template>
  <div v-if="is_master_loaded" class="main-in">
    <div class="main-content">
      <ul class="nav nav-tabs">
        <li :class="{ 'active' : query.status == 0 }">
          <a @click="handleFilterStatus({status: 0})">すべて<span v-if="count.total" class="rsv-status__all">{{ count.total }}</span>
        </a></li>
        <li :class="{ 'active' : query.status == 5 }">
          <a @click="handleFilterStatus({status: 5})">未対応<span v-if="count.not_supported" class="rsv-status__not_supported">{{ count.not_supported }}</span></a>
        </li>
        <li :class="{ 'active' : query.status == 10 }">
          <a @click="handleFilterStatus({status: 10})">不在着信<span v-if="count.missed_call" class="rsv-status__missed_call">{{ count.missed_call }}</span></a>
        </li>
        <li :class="{ 'active' : query.status == 15 }">
          <a @click="handleFilterStatus({status: 15})">日時確定<span v-if="count.in_progress" class="rsv-status__in_progress">{{ count.in_progress }}</span></a>
        </li>
        <!-- <li :class="{ 'active' : query.status == 20 }">
          <a @click="handleFilterStatus({status: 20})">予約完了<span v-if="count.approved" class="rsv-status__approved">{{ count.approved }}</span></a>
        </li> -->
      </ul>
      <div class="tab-content">
        <div id="tab-content1">
          <table class="task-list">
            <thead>
              <tr>
                <th>{{ $t('予約ID') }}</th>
                <th>{{ $t('ステータス') }}</th>
                <th>{{ $t('送受信時間') }}</th>
                <th>{{ $t('氏名') }}</th>
                <th>{{ $t('性別') }}</th>
                <th>{{ $t('電話番号') }}</th>
                <th>{{ $t('予約方法') }}</th>
                <th>{{ $t('予約内容') }}</th>
                <th>{{ $t('チャット') }}</th>
                <th>{{ $t('確定日') }}</th>
              </tr>
            </thead>
            <tbody v-if="reservations.length > 0">
              <tr v-for="rsv in reservations" :key="rsv.id">
                <td>{{ rsv.id }}</td>
                <td>
                  <rsv-status-select
                    :rsv-id="rsv.id"
                    :selected="rsv.status"
                    @change="handleChangeStatus" />
                </td>
                <td v-if="rsv.last_chat_time">{{ rsv.last_chat_time.created_at | formatDateWithTime}}</td>
                <td v-else>{{ $t('未確定') }}</td>
                <td>
                  <small>{{ rsv.patient_info.kana }}</small>
                  <br>
                  <span>{{ rsv.patient_info.name }}</span>
                </td>
                <td>{{ gender_types[rsv.patient_info.gender] || '' }}</td>
                <td>{{ rsv.patient_info.phone_number }}</td>
                <td>
                  <div v-if="rsv.source == '5'" class="source-info"><img src="/img/msg.svg">{{ $t('チャット') }}</div>
                  <div v-if="rsv.source == '10'" class="source-info"><img src="/img/tel.svg">{{ $t('電話予約') }}</div>
                </td>
                <td>{{ rsv.rsv_content && rsv.rsv_content.name }}</td>
                <td>
                  <router-link :to="{ name: 'mailbox', params: { id: rsv.id }}" class="btn-primary normal-btn">チャット</router-link>
                </td>
                <td>
                  <button v-if="rsv.source == '10' || ['20', '25', '30'].includes(rsv.status)" type="button" class="btn-primary normal-btn" @click="showRsvModal(rsv.id)">{{ $t('日時') }}</button>
                </td>
              </tr>
            </tbody>
          </table>
          <pagination
            v-if="pageInfo"
            :page="query.page"
            :page-count="pageInfo.last_page"
            :click-handler="handlePaginate" /> 
        </div>
      </div>
    </div>
    <form-modal
      ref="modal"
      :title="$t('予約内容')"
      >
      <div v-if="form && selected" class="reserve-content">
        <ul>
          <li>  
            <div>{{ $t('診察者') }}</div>
            <div class="rsv-main-content">
              <div>
                <span>{{ $t('名前') }}</span>
                <!-- {{ selected.patient_info.name }} -->
                {{ selected.patient_info.kana }}
              </div>
              <!-- <div>
                <span>{{ $t('シメイ') }}</span>
                {{ selected.patient_info.kana }}
              </div> -->
              <!-- <div class="half"> -->
                <div>
                  <span>{{ $t('性別') }}</span>
                  {{ gender_types[selected.patient_info.gender] }}
                </div>
                <div>
                  <span>{{ $t('年齢') }}</span>
                  {{ selected.patient_info.age }}
                </div>
              <!-- </div> -->
              <div>
                <span>{{ $t('生年月日') }}</span>
                {{ selected.patient_info.birthday | formatDate }}
              </div>
              <div>
                <span>{{ $t('電話番号') }}</span>
                  {{ selected.patient_info.phone_number }}
              </div>
            </div>
          </li>
          <li>
            <div>{{ $t('予約日') }}</div>
            <div class="rsv-main-content2">
              <div>
                <span>{{ $t('日にち') }}</span>
                <!-- <input type="date" :min="currentDate" v-model="form.reservations.visit_date" :class="{'is-invalid' : errors && errors['reservations.visit_date'] }"/> -->
                <v-date-picker v-model="date">
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
                <!-- <input type="time" v-model="form.reservations.start_time" :class="{'is-invalid' : errors && errors['reservations.start_time'] }" /> -->
                <vue-timepicker fixed-dropdown-button placeholder=" " v-model="form.reservations.start_time" :class="{'is-invalid' : errors && errors['reservations.start_time'] }" :hour-range="[0, [6, 23]]" :minute-interval="15"></vue-timepicker>
                <div v-if="errors && errors['reservations.start_time']" class="error invalid-feedback">{{ errors['reservations.start_time'][0] }}</div>
              </div>
              <!-- <div>
                <span></span>
                <input type="time" v-model="form.reservations.end_time" :class="{'is-invalid' : errors && errors['reservations.end_time'] }" />
                <div v-if="errors && errors['reservations.end_time']" class="error invalid-feedback">{{ errors['reservations.end_time'][0] }}</div>
              </div> -->
            </div>
          </li>
          <li>
            <div>{{ $t('担当者') }}</div>
            <div class="rsv-main-content2">
              <div>
                <span>{{ $t('医師・スタッフ') }}</span>
                <select v-model="form.reservations.stuff_id" :class="{'is-invalid' : errors && errors['reservations.stuff_id'] }">
                  <option></option>
                  <option v-for="(name, id) in stuffs" :key="id" :value="id">{{ name }}</option>
                </select>
                <div v-if="errors && errors['reservations.stuff_id']" class="error invalid-feedback">{{ errors['reservations.stuff_id'][0] }}</div>
              </div>
              <div>
                <span>{{ $t('予約内容') }}</span>
                <select v-model="form.reservations.rsv_content_id" :class="{'is-invalid' : errors && errors['reservations.rsv_content_id'] }">
                  <option></option>
                  <option v-for="(name, id) in rsv_contents" :key="id" :value="id">{{ name }}</option>
                </select>
                <div v-if="errors && errors['reservations.rsv_content_id']" class="error invalid-feedback">{{ errors['reservations.rsv_content_id'][0] }}</div>
              </div>
              <!-- <div>
                <span>{{ $t('施術メニュー') }}</span>
                <select v-model="form.reservations.menu_id" :class="{'is-invalid' : errors && errors['reservations.menu_id'] }">
                  <option></option>
                  <option v-for="(name, id) in menus" :key="id" :value="id">{{ name }}</option>
                </select>
                <div v-if="errors && errors['reservations.menu_id']" class="error invalid-feedback">{{ errors['reservations.menu_id'][0] }}</div>
              </div> -->
            </div>
          </li>
          <!-- <li class="rsv-modal--point-row">
            <div>{{ $t('利用ポイント') }}</div>
            <div class="point-content">
              <span class="use-point">{{ form.reservations.use_point }}ポイント</span>
              <p>※1ポイント＝1円です。お支払いの際ポイント分を割引きしてください。</p>
            </div>
          </li> -->
        </ul>
      </div>
      <div class="btn-wrapper">
        <button type="button" class="btn btn-primary" @click="handleConfirmRsv">{{ $t('予約を確定する') }}</button>
      </div>
    </form-modal>
  </div>
</template>

<script>
import axios from 'axios'
import { mapGetters } from 'vuex'
import RsvStatusSelect from '~/components/RsvStatusSelect'

export default {
  middleware: 'auth',

  components: {
    RsvStatusSelect
  },

  data() {
    return {
      reservations: [],
      query: {
        per_page: 20,
        page: 1,
        status: 0,
      },
      currentDate: new Date().toISOString().substr(0, 10),
      form: undefined,
      selected: undefined,
      count: {
        total: 0,
        not_supported: 0,
        missed_call: 0,
        in_progress: 0,
      },
      pageInfo: undefined,
      errors: undefined,
    }
  },

  computed: mapGetters({
    is_master_loaded: 'state/is_master_loaded',
    gender_types: 'constant/gender_types',
    stuffs: 'data/stuffs',
    menus: 'data/menus',
    rsv_contents: 'data/rsv_contents',
  }),

  mounted() {
    this.getData();
  },

  methods: {
    getData() {
      this.$store.dispatch('state/setIsLoading')
      const qs = this.$utils.getQueryString(this.query)
      axios.get(`/api/clinic/reservations?${qs}`)
        .then(res => {
          this.reservations = res.data.reservations.data;
          this.pageInfo = {
            last_page: res.data.reservations.last_page,
          }
          this.count = {
            total: res.data.count.all,
            not_supported: res.data.count.not_supported,
            missed_call: res.data.count.missed_call,
            in_progress: res.data.count.in_progress,
            approved: res.data.count.approved,
          }
          this.$store.dispatch('state/removeIsLoading')
        })
        .catch(error => {
          this.$store.dispatch('state/removeIsLoading')
        })
    },

    getList(params) {
      this.query = {
        ...this.query,
        ...params
      }
      if (params.status == 0) {
        this.reservations = this.originals
      } else {
      this.reservations = this.originals.filter(el => el.status == params.status)
      }
    },

    showRsvModal(rsvId) {
      this.errors = {}
      this.selected = this.reservations.find(el => el.id == rsvId);
      this.form = {
        reservations: {
          visit_date: this.selected.visit_date,
          start_time: this.selected.start_time,
          end_time: this.selected.end_time,
          stuff_id: this.selected.stuff_id,
          rsv_content_id: this.selected.rsv_content_id,
          menu_id: this.selected.menu_id,
          use_point: this.selected.use_point,
        }
      }
      this.$refs.modal.show()
    },

    handleConfirmRsv() {
      this.$store.dispatch('state/setIsLoading')
      axios.put(`/api/clinic/reservations/${this.selected.id}`, this.form)
        .then(res => {
          let rsv = res.data.reservation
          this.reservations = this.reservations.map(el => {
            if (el.id == rsv.id) {
              return rsv
            }
            return el
          })
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
          // this.$swal({
          //   toast: true,
          //   position: 'top-end',
          //   showConfirmButton: false,
          //   timer: 3000,
          //   title: '変更できません。',
          //   icon: 'error',
          // })
        })
    },

    handleChangeStatus(rsvId, newStatus) {
      let rsv = this.reservations.find(item => item.id == rsvId);
      if (!rsv) return;
      let originalStatus = rsv.status
      this.$swal({
        title: '本当に変更しますか？',
        icon: 'warning',
        showCancelButton: true,
      }).then((result) => {
        if (result.value) {
          this.$store.dispatch('state/setIsLoading')
          axios.get(`/api/clinic/reservations/${rsvId}/status/${newStatus}`)
            .then(res => {
              this.reservations = this.reservations.map(el => {
                if (el.id == rsvId) el.status = newStatus
                return el
              })
              if (originalStatus == 5) this.count.not_supported--
              else if (originalStatus == 10) this.count.missed_call--
              else if (originalStatus == 15) this.count.in_progress--

              if (newStatus == 5) this.count.not_supported++
              else if (newStatus == 10) this.count.missed_call++
              else if (newStatus == 15) this.count.in_progress++
              this.$store.dispatch('state/removeIsLoading')
            })
            .catch(error => {
              this.$store.dispatch('state/removeIsLoading')
            })
        }
      })
    },

    handleFilterStatus(obj) {
      this.query = {
        ...this.query,
        page: 1,
        ...obj
      }
      this.getData()
    },

    handlePaginate(pageNum) {
      this.query = {
        ...this.query,
        page: pageNum,
      }
      this.getData()
    },
  },

  // filters: {
  //   last_chat_time_filter(value) {
  //     if (value) return value;

  //     return "未確定";
  //   },
  // }
}
</script>

<style scoped>
</style>
