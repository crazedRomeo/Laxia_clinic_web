<template>
  <div v-if="is_master_loaded" class="main-in">
    <div class="main-content">
      <ul class="nav nav-tabs">
        <li :class="{ 'active' : query.status == 0 }">
          <a @click="handleFilterStatus({status: 0})">すべて
            <!-- <span v-if="count.total" class="rsv-status__all">{{ count.total }}</span> -->
          </a>
        </li>
        <li :class="{ 'active' : query.status == 5 }">
          <a @click="handleFilterStatus({status: 5})">未対応<span v-if="count.not_supported" class="rsv-status__not_supported">{{ count.not_supported }}</span></a>
        </li>
        <li :class="{ 'active' : query.status == 10 }">
          <a @click="handleFilterStatus({status: 10})">不在着信
            <!-- <span v-if="count.missed_call" class="rsv-status__missed_call">{{ count.missed_call }}</span> -->
          </a>
        </li>
        <li :class="{ 'active' : query.status == 15 }">
          <a @click="handleFilterStatus({status: 15})">日時確定
            <!-- <span v-if="count.in_progress" class="rsv-status__in_progress">{{ count.in_progress }}</span> -->
          </a>
        </li>
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
                <th>{{ $t('確定日') }}</th>
              </tr>
            </thead>
            <tbody v-if="reservations.length > 0">
              <tr v-for="rsv in reservations" :key="rsv.id" @click="toMailbox(rsv.mailbox.id)">
                <td>{{ rsv.id }}</td>
                <td>
                    <div class="rsv-status-select"><h4 :class="rsv.status == 5 ? 'not-supported' : 'in-progress'">{{ rsv_status_types[rsv.status] }}</h4></div>
                </td>
                <td v-if="rsv.last_chat_time && getDate(rsv.last_chat_time.created_at) == getDate(new Date())">
                  {{ rsv.last_chat_time.created_at | formatTime12}}
                </td>
                <td v-else-if="rsv.last_chat_time">
                  {{ rsv.last_chat_time.created_at | formatDateWithDay }}
                  <br>
                  {{ rsv.last_chat_time.created_at | formatTime12}}
                </td>
                <td v-else></td>
                <td>
                  {{ rsv.patient? rsv.patient.kana : '' }}
                </td>
                <td>{{ rsv.patient? gender_types[rsv.patient.gender] : '' }}</td>
                <td>{{ rsv.patient? rsv.patient.phone_only_number : '' | formatTelephone }}</td>
                <td>
                  <div v-if="rsv.type == 5" class="source-info"><img src="/img/msg.svg">{{ $t('チャット') }}</div>
                  <div v-if="rsv.type == 10" class="source-info"><img src="/img/tel.svg">{{ $t('電話予約') }}</div>
                </td>
                <td>{{ hope_treat_types[rsv.hope_treat] }}</td>
                <!-- <td>
                  <router-link :to="{ name: 'mailbox', params: { id: rsv.id }}" class="btn-primary normal-btn">チャット</router-link>
                </td> -->
                <td>
                  <button v-if="rsv.status == 5" type="button" class="btn-primary normal-btn" v-on:click.stop="showRsvModal(rsv.id)">{{ $t('日時') }}</button>
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
      @cancel="clearRsvModal"
      >
      <div v-if="form && selected" class="reserve-content">
        <ul>
          <li>
            <div>{{ $t('診察者') }}</div>
            <div class="rsv-main-content">
              <div>
                <span>{{ $t('名前') }}</span>
                {{ selected.patient? selected.patient.kana : '' }}
              </div>
              <div>
                <span>{{ $t('性別') }}</span>
                {{ selected.patient? gender_types[selected.patient.gender] : '' }}
              </div>
              <div>
                <span>{{ $t('年齢') }}</span>
                {{ selected.patient? selected.patient.age : '' }}
              </div>
              <div>
                <span>{{ $t('生年月日') }}</span>
                {{ selected.patient? selected.patient.birthday : '' | formatDate }}
              </div>
              <div>
                <span>{{ $t('電話番号') }}</span>
                  {{ selected.patient? selected.patient.phone_number : '' }}
              </div>
            </div>
          </li>
          <li>
            <div>{{ $t('予約日') }}</div>
            <div class="rsv-main-content2">
              <div>
                <span>{{ $t('日にち') }}</span>
                <!-- <input type="date" :min="currentDate" v-model="form.reservations.visit_date" :class="{'is-invalid' : errors && errors['reservations.visit_date'] }"/> -->
                <v-date-picker
                  v-model="form.reservations.visit_date"
                  :masks="{ L: 'YYYY-MM-DD' }"
                  :attributes="attrs"
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
                <vue-timepicker fixed-dropdown-button placeholder=" " v-model="form.reservations.start_time" :class="{'is-invalid' : errors && errors['reservations.start_time'] }" :hour-range="[[6, 23]]" :minute-interval="15">
                  <template v-slot:dropdownButton>
                    <img src="/img/polygon.svg" /> 
                  </template>
                </vue-timepicker>

                <div v-if="errors && errors['reservations.start_time']" class="error invalid-feedback">{{ errors['reservations.start_time'][0] }}</div>
              </div>
            </div>
          </li>
          <li>
            <div>{{ $t('担当者') }}</div>
            <div class="rsv-main-content2">
              <div>
                <span>{{ $t('医師') }}</span>
                <!-- <select v-model="form.reservations.doctor_id" :class="{'is-invalid' : errors && errors['reservations.doctor_id'] }">
                  <option></option>
                  <option v-for="(doctor) in doctors" :key="doctor.id" :value="doctor.id">{{ doctor.kata_name }}</option>
                </select> -->
                <c-select
                  :options="doctors"
                  :textkey="'kata_name'"
                  :valkey="'id'"
                  :emptyable="true"
                  :default="form.reservations.doctor_id"
                  class="select"
                  ref="doctorSelect"
                  @change="selectedDoctor"
                />
                <div v-if="errors && errors['reservations.doctor_id']" class="error invalid-feedback">{{ errors['reservations.doctor_id'][0] }}</div>
              </div>
              <div>
                <span>{{ $t('予約内容') }}</span>
                <!-- <select v-model="form.reservations.hope_treat" :class="{'is-invalid' : errors && errors['reservations.hope_treat'] }">
                  <option></option>
                  <option v-for="(name, id) in hope_treat_types" :key="id" :value="id">{{ name }}</option>
                </select> -->
                <c-enum-select
                  :options="hope_treat_types"
                  :emptyable="true"
                  :default="form.reservations.hope_treat"
                  class="select"
                  ref="hopeTreatSelect"
                  @change="selectedHopeTreat"
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
  </div>
</template>

<script>
import axios from 'axios'
import { mapGetters } from 'vuex'
import RsvStatusSelect from '~/components/RsvStatusSelect'

const moment = require('moment')
require('moment/locale/ja')
Vue.use(require('vue-moment'), { moment })

export default {
  middleware: 'auth',

  components: {
    RsvStatusSelect
  },

  data() {
    return {
      reservations: [],
      doctors: [],
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
        // missed_call: 0,
        in_progress: 0,
      },
      pageInfo: undefined,
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
    }
  },

  computed: mapGetters({
    is_master_loaded: 'state/is_master_loaded',
    gender_types: 'constant/gender_types',
    menus: 'data/menus',
    rsv_status_types: 'constant/rsv_status_types',
    hope_treat_types: 'constant/hope_treat_types',
  }),

  mounted() {
    this.getCommonData();
    this.getData();
  },

  methods: {
    getCommonData() {
      this.$store.dispatch('state/setIsLoading')

      axios.get(`/api/clinic/reservations/common_data`)
        .then(res => {
          this.doctors = res.data.doctors;

          this.$store.dispatch('state/removeIsLoading')
        })
        .catch(error => {
          this.$store.dispatch('state/removeIsLoading')
        })
    },
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
            // missed_call: res.data.count.missed_call,
            in_progress: res.data.count.in_progress,
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
          doctor_id: this.selected.doctor_id,
          hope_treat: this.selected.hope_treat,
        }
      }

      if(this.$refs.doctorSelect) this.$refs.doctorSelect.set(this.form.reservations.doctor_id);
      if(this.$refs.hopeTreatSelect) this.$refs.hopeTreatSelect.set(this.form.reservations.hope_treat);
      this.$refs.modal.show();
    },

    clearRsvModal() {
      // this.$refs.doctorSelect.clear();
      // this.$refs.hopeTreatSelect.clear();
    },

    handleConfirmRsv() {
      this.$store.dispatch('state/setIsLoading')
      this.form.reservations.start_time = this.form.reservations.start_time.HH + ':' + this.form.reservations.start_time.mm;
      this.form.reservations.visit_date = (new Date(this.form.reservations.visit_date)).toISOString().substring(0, 10);

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

    toMailbox(mailbox_id) {
      this.$router.push({name: 'mailbox', params: {'id': mailbox_id}});
    },

    getDate(date_str) {
      return moment(String(date_str)).format('YYYY-MM-DD');
    },

    selectedDoctor(selected_option) {
      this.form.reservations.doctor_id = selected_option ? selected_option.id : null;
    },

    selectedHopeTreat(selected_option) {
      this.form.reservations.hope_treat = selected_option;
    }
  },

  // filters: {
  //   last_chat_time_filter(value) {
  //     if (value) return value;

  //     return "未確定";
  //   },
  // }
}
</script>

<style lang="scss" scoped>
.rsv-status-select {
	width: 115px;
	position: relative;
  margin: auto;
	h4 {
		position: relative;
		height: 25px;
		// display: flex;
		// justify-content: flex-start;
		font-size: 14px;
		color: white;
		align-items: center;
		// padding-left: 20px;
		border-radius: 45px;
		background-color: #294884;
		cursor: pointer;
		&.not-supported {
			color: #F65C5C;
			background-color: rgba(255, 206, 206, .5);
			svg {
				fill: #F65C5C;
			}
		}
		&.missed-call {
			color: #E0953D;
			background-color: rgba(255, 222, 191, .5);
			svg {
				fill: #E0953D;
			}
		}
		&.in-progress {
			color: #878787;
			background-color: #EAEAEA;
			svg {
				fill: #3E9969;
			}
		}
		&.approved {
			color: #3D99E0;
			background-color: rgba(191, 227, 255, .5);
			svg {
				fill: #3D99E0;
			}
		}
		svg {
			position: absolute;
			right: 8px;
			top: 50%;
    	transform: translateY(-50%);
		}
	}
	&.light {
		h4 {
			background-color: #fff;
			color: #333;
			border: 1px solid #333;
		}
	}
	.dropdown__container {
		position: absolute;
		height: 0;
		top: 0;
		left: 0;
		width: 115px;
		border-radius: 10px;
		overflow: hidden;
		list-style: none;
		padding-left: 0;
		background-color: white;
		box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
		z-index: 500;
		&.dropped {
			top: 30px;
			height: auto;
		}
		li {
			a {
				width: 100%;
				height: 30px;
				display: flex;
				align-items: center;
				font-size: 14px;
				font-weight: bold;
				padding-left: 20px;
				color: #131340 !important;
				cursor: pointer;
				&:hover {
					background-color: #F0F0F0;
				}
				&.selected {
					background-color: #F0F0F0;
				}
			}
		}
	}
}
</style>
