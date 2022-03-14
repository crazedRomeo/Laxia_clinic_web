<template>
  <div v-if="is_master_loaded" class="main-in">
    <div class="main-content">
      <div class="date-pick">
        <button @click="handleSelectDate('prev')"><img src="/img/date-prev.svg"></button>
        <p><input type="date" v-model="query.selected_date"> <span class="select-current-date-btn" @click="handleSelectDate('current')">{{ $t('今日') }}</span></p>
        <button @click="handleSelectDate('next')"><img src="/img/date-next.svg"></button>
      </div>
      <div class="tab-content">
        <table class="task-list">
          <thead>
            <tr>
              <th>{{ $t('来院日時') }}</th>
              <th>{{ $t('診断時間') }}</th>
              <th>{{ $t('氏名') }}</th>
              <th>{{ $t('性別') }}</th>
              <th>{{ $t('診断メニュー') }}</th>
              <th>{{ $t('担当医師') }}</th>
              <th>{{ $t('予約内容') }}</th>
              <th>{{ $t('詳細') }}</th>
              <th>{{ $t('支払い') }}</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, index) in reservations" :key="index">
              <td>{{ item.visit_date | formatDateWithDay }}</td>
              <td>{{ item.visit_time }}</td>
              <td>
                <small>{{ item.patient_info.kana }}</small>
                <br>
                {{ item.patient_info.name }}
              </td>
              <td>{{ item.patient_info.gender && gender_types[item.patient_info.gender] }}</td>
              <td>{{ item.menu ? item.menu.name : '' }}</td>
              <td>{{ item.stuff ? item.stuff.name : '' }}</td>
              <td>{{ item.rsv_content ? item.rsv_content.name : '' }}</td>
              <td>
                <button type="button" class="btn-primary normal-btn" @click="handleShowRsvModal(item.id)">{{ $t('詳細') }}</button>
              </td>
              <td>
                <button type="button" class="btn-primary normal-btn" @click="handleShowPaymentModal(item.id)">{{ $t('決済') }}</button>
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
    <form-modal
      ref="rsvModal"
      id="reservation-modal"
      :title="$t('予約内容')"
      @cancel="handleModalClose"
      >
      <div v-if="!isEditing">
        <div v-if="selectedRsv" class="reserve-content">
          <ul>
            <li>
              <div>{{ $t('診察者') }}</div>
              <div class="rsv-main-content">
                <!-- <div>
                  <span>{{ $t('氏名') }}({{ $t('漢字') }})</span>
                  {{ selectedRsv.patient_info.name }}
                </div> -->
                <div>
                  <span>{{ $t('名前') }}</span>
                  {{ selectedRsv.patient_info.kana }}
                </div>
                <!-- <div class="half"> -->
                  <div>
                    <span>{{ $t('性別') }}</span>
                  {{ selectedRsv.patient_info.gender && gender_types[selectedRsv.patient_info.gender] }}
                  </div>
                  <div>
                    <span>{{ $t('年齢') }}</span>
                  {{ selectedRsv.patient_info.age }}
                  </div>
                <!-- </div> -->
                <div>
                  <span>{{ $t('電話番号') }}</span>
                  {{ selectedRsv.patient_info.phone_number }}
                </div>
                <div>
                  <span>{{ $t('生年月日') }}</span>
                  {{ selectedRsv.patient_info.birthday | formatDate }}
                </div>
              </div>
            </li>
            <li>
              <div>{{ $t('予定日') }}</div>
              <div class="rsv-main-content2">
                <div>
                  <span>{{ $t('日にち') }}</span>
                  {{ selectedRsv.visit_date | formatDateWithDay }}
                </div>
                <div>
                  <span>{{ $t('診察時間') }}</span>
                  {{ selectedRsv.visit_time }}
                </div>
              </div>
            </li>
            <li>
              <div>{{ $t('担当者') }}</div>
              <div class="rsv-main-content2">
                <div>
                  <span>{{ $t('医師・スタッフ') }}</span>
                  {{ selectedRsv.stuff && selectedRsv.stuff.name }}
                </div>
                <div>
                  <span>{{ $t('予約内容') }}</span>
                  {{ selectedRsv.rsv_content && selectedRsv.rsv_content.name }}
                </div>
                <!-- <div>
                  <span>{{ $t('施術メニュー') }}</span>
                  {{ selectedRsv.menu && selectedRsv.menu.name }}
                </div> -->
              </div>
            </li>
          </ul>
        </div>
        <div class="btn-payment-wrapper">
          <div class="btn-wrapper">
            <button type="button" class="btn btn-danger" @click="handleModalClose">{{ $t('予約をキャンセル') }}</button>
          </div>
          <div class="btn-wrapper">
            <button type="button" class="btn btn-primary" @click="handleEditRsv">{{ $t('予約を編集する') }}</button>
          </div>
        </div>
        
      </div>
      <div v-else>
        <div v-if="selectedRsv" class="reserve-content">
          <ul>
            <li>
              <div>{{ $t('予定日') }}</div>
              <div>
                <div>
                  <span>{{ $t('日にち') }}</span>
                  <input type="date" v-model="rsv_form.reservations.visit_date" :class="{'is-invalid' : errors && errors['reservations.visit_date'] }">
                  <div v-if="errors && errors['reservations.visit_date']" class="error invalid-feedback">{{ errors['reservations.visit_date'][0] }}</div>
                </div>
                <div class="full">
                  <span>{{ $t('診察時間') }}</span>
                  <div class="time-wrapper">
                    <div>
                      <input type="time" v-model="rsv_form.reservations.start_time" :class="{'is-invalid' : errors && errors['reservations.start_time'] }">
                      <div v-if="errors && errors['reservations.start_time']" class="error invalid-feedback">{{ errors['reservations.start_time'][0] }}</div>
                    </div>
                    <span> ~ </span>
                    <div>
                      <input type="time" v-model="rsv_form.reservations.end_time" :class="{'is-invalid' : errors && errors['reservations.end_time'] }">
                      <div v-if="errors && errors['reservations.end_time']" class="error invalid-feedback">{{ errors['reservations.end_time'][0] }}</div>
                    </div>
                  </div>
                </div>
              </div>
            </li>
            <li>
              <div>{{ $t('担当者') }}</div>
              <div>
                <div>
                  <span>{{ $t('医師・スタッフ') }}</span>
                  <select v-model="rsv_form.reservations.stuff_id" :class="{'is-invalid' : errors && errors['reservations.stuff_id'] }">
                    <option v-for="(name, id) in stuffs" :key="id" :value="id">{{ name }}</option>
                  </select>
                  <div v-if="errors && errors['reservations.stuff_id']" class="error invalid-feedback">{{ errors['reservations.stuff_id'][0] }}</div>
                </div>
                <div>
                  <span>{{ $t('予約内容') }}</span>
                  <select v-model="rsv_form.reservations.rsv_content_id" :class="{'is-invalid' : errors && errors['reservations.rsv_content_id'] }">
                    <option v-for="(name, id) in rsv_contents" :key="id" :value="id">{{ name }}</option>
                  </select>
                  <div v-if="errors && errors['reservations.rsv_content_id']" class="error invalid-feedback">{{ errors['reservations.rsv_content_id'][0] }}</div>
                </div>
                <div>
                  <span>{{ $t('施術メニュー') }}</span>
                  <select v-model="rsv_form.reservations.menu_id" :class="{'is-invalid' : errors && errors['reservations.menu_id'] }">
                    <option v-for="(name, id) in menus" :key="id" :value="id">{{ name }}</option>
                  </select>
                  <div v-if="errors && errors['reservations.menu_id']" class="error invalid-feedback">{{ errors['reservations.menu_id'][0] }}</div>
                </div>
              </div>
            </li>
            <li>
              <div>{{ $t('診察者') }}</div>
              <div>
                <div>
                  <span>{{ $t('氏名') }}({{ $t('漢字') }})</span>
                  <div class="name-wrapper">
                    <div>
                      <input type="text" name="" v-model="rsv_form.patient_infos.name01" :class="{'is-invalid' : errors && errors['patient_infos.name01'] }">
                      <div v-if="errors && errors['patient_infos.name01']" class="error invalid-feedback">{{ errors['patient_infos.name01'][0] }}</div>
                    </div>
                    <div>
                      <input type="text" name="" v-model="rsv_form.patient_infos.name02" :class="{'is-invalid' : errors && errors['patient_infos.name02'] }">
                      <div v-if="errors && errors['patient_infos.name02']" class="error invalid-feedback">{{ errors['patient_infos.name02'][0] }}</div>
                    </div>
                  </div>                  
                </div>
                <div>
                  <span>{{ $t('氏名') }}({{ $t('カタカナ') }})</span>
                  <div class="name-wrapper">
                    <div>
                      <input type="text" name="" v-model="rsv_form.patient_infos.kana01" :class="{'is-invalid' : errors && errors['patient_infos.kana01'] }">
                      <div v-if="errors && errors['patient_infos.kana01']" class="error invalid-feedback">{{ errors['patient_infos.kana01'][0] }}</div>
                    </div>
                    <div>
                      <input type="text" name="" v-model="rsv_form.patient_infos.kana02" :class="{'is-invalid' : errors && errors['patient_infos.kana02'] }">
                      <div v-if="errors && errors['patient_infos.kana02']" class="error invalid-feedback">{{ errors['patient_infos.kana02'][0] }}</div>
                    </div>
                  </div>              
                </div>
                <br>
                <div>
                  <span>{{ $t('性別') }}</span>
                  <select v-model="rsv_form.patient_infos.gender" :class="{'is-invalid' : errors && errors['patient_infos.gender'] }">
                    <option v-for="(item, key) in gender_types" :key="key" :value="key">{{ item }}</option>
                  </select>
                  <div v-if="errors && errors['patient_infos.gender']" class="error invalid-feedback">{{ errors['patient_infos.gender'][0] }}</div>
                </div>
                <div>
                  <span>{{ $t('電話番号') }}</span>
                  <input type="text" name="" v-model="rsv_form.patient_infos.phone_number" :class="{'is-invalid' : errors && errors['patient_infos.phone_number'] }">
                  <div v-if="errors && errors['patient_infos.phone_number']" class="error invalid-feedback">{{ errors['patient_infos.phone_number'][0] }}</div>
                </div>
                <div>
                  <span>{{ $t('生年月日') }}</span>
                  <input type="date" v-model="rsv_form.patient_infos.birthday" :class="{'is-invalid' : errors && errors['patient_infos.birthday'] }">
                  <div v-if="errors && errors['patient_infos.birthday']" class="error invalid-feedback">{{ errors['patient_infos.birthday'][0] }}</div>
                </div>
              </div>
            </li>
          </ul>
        </div>
        <div class="btn-wrapper">
          <button type="button" class="btn btn-primary" @click="handleUpdateRsv">{{ $t('編集を完了する') }}</button>
        </div>
      </div>
    </form-modal>
    <form-modal
      ref="paymentModal"
      id="payment-modal"
      :title="$t('決済内容')"
      @cancel="handleModalClose"
      >
      <div v-if="selectedRsv && form" class="reserve-content2">
        <div>
          <div>
            <span>{{ selectedRsv.patient_info.kana }}</span>
            <!-- {{ selectedRsv.patient_info.name }} -->
          </div>
          <div>
            <span></span>
            {{ selectedRsv.patient_info.age }}歳/{{ selectedRsv.patient_info.gender && gender_types[selectedRsv.patient_info.gender] }}
          </div>
        </div>
        <div class="rsv-summary-content">
          <div>
            <span>{{ $t('来院日時') }}</span>
            {{ selectedRsv.visit_date | formatDateWithDay }}　{{ selectedRsv.visit_time }}
          </div>
          <div>
            <span>{{ $t('予約内容') }}</span>
            {{ selectedRsv.rsv_content && selectedRsv.rsv_content.name }}
          </div>
          <div>
            <span>{{ $t('施術メニュー') }}</span>
            {{ selectedRsv.menu && selectedRsv.menu.name }}
          </div>
        </div>

        <div>{{ $t('会計金額') }}</div>
        <div class="treat-calc--wrapper">
          <div>
            <div>
              <span>{{ $t('合計金額') }}({{ $t('税抜') }})</span>
              <input type="number" name="" v-model="form.payments.total_price" min="1" :class="{'is-invalid' : errors && errors['payments.total_price'] }">
              <div v-if="errors && errors['payments.total_price']" class="error invalid-feedback">{{ errors['payments.total_price'][0] }}</div>
            </div>
          </div>
          <span class="operator">　ー　</span>
          <div>
            <div>
              <span>{{ $t('施術金額') }}</span>
              <input type="number" name="" v-model="form.payments.except_price" min="0" :class="{'is-invalid' : errors && errors['payments.except_price'] }">
              <div v-if="errors && errors['payments.except_price']" class="error invalid-feedback">{{ errors['payments.except_price'][0] }}</div>
              <!-- <span>{{ $t('除外項目') }}</span>
              <input type="text" name="" v-model="form.payments.except_item" :class="{'is-invalid' : errors && errors['payments.except_item'] }"> -->
              <div v-if="errors && errors['payments.except_item']" class="error invalid-feedback">{{ errors['payments.except_item'][0] }}</div>
            </div>
          </div>
          <span class="operator">　ー　</span>
          <div>
            <div>
              <span>{{ $t('利用ポイント') }}</span>
              <p class="payment-use-point">{{ selectedRsv.use_point }}</p>
            </div>
          </div>
          <span class="operator"> =  </span>
          <div>
            <div>
              <span>{{ $t('施術金額') }}({{ $t('税抜') }})</span>
              <input class="payment-result" type="text" name="" disabled v-model="treat_price">
            </div>
          </div>
        </div>
      </div>
      <div class="btn-wrapper">
        <button type="button" class="btn btn-primary" @click="handleSavePayment">{{ $t('成果を決定する') }}</button>
      </div>
    </form-modal>
  </div>
</template>

<script>
import axios from 'axios'
import { mapGetters } from 'vuex'

export default {
  middleware: 'auth',

  data() {
    return {
      // 予約ステータスが「調整完了」である予約一覧取得
      reservations: [],
      query: {
        per_page: 20,
        page: 1,
        selected_date: new Date().toISOString().substr(0, 10),
      },
      isEditing: false,
      selectedRsv: undefined,
      form: undefined,
      form_tmp: {
        payments: {
          total_price: '',
          except_item: '',
          except_price: '',
          treat_price: '',
        }
      },
      rsv_form: undefined,
      rsv_form_tmp: {
        reservations: {
          visit_date: '',
          start_time: '',
          end_time: '',
          stuff_id: '',
          rsv_content_id: '',
          menu_id: '',
        },
        patient_infos: {
          name01: '',
          name02: '',
          kana01: '',
          kana02: '',
          gender: '',
          phone_number: '',
          birthday: '',
        }
      },
      pageInfo: undefined,
      errors: undefined
    }
  },

  mounted() {
    this.getData();
  },

  computed: {
    ...mapGetters({
      is_master_loaded: 'state/is_master_loaded',
      gender_types: 'constant/gender_types',
      stuffs: 'data/stuffs',
      menus: 'data/menus',
      rsv_contents: 'data/rsv_contents',
    }),
    treat_price: function() {
      return this.form.payments.total_price - this.form.payments.except_price - this.selectedRsv.use_point;
    },
    years () {
      const year = new Date().getFullYear()
      const length = 40
      return Array.from({length: length}, (value, index) => year - length + index)
    }
  },

  methods: {
    getData() {
      this.$store.dispatch('state/setIsLoading')
      const qs = this.$utils.getQueryString(this.query)
      axios.get(`/api/clinic/reservations/payments?${qs}`)
        .then(res => {
          this.reservations = res.data.reservations.data;
          this.pageInfo = {
            last_page: res.data.reservations.last_page,
          }
          this.$store.dispatch('state/removeIsLoading')
        })
        .catch(error => {
          this.$store.dispatch('state/removeIsLoading')
        })
    }, 

    handleSelectDate(param) {
      if (param == 'current') {
        this.query.selected_date = this.$moment().format('YYYY-MM-DD')
      } else if (param == 'next') {
        this.query.selected_date = this.$moment(this.query.selected_date).add(1,'days').format('YYYY-MM-DD');
      } else if (param == 'prev') {
        this.query.selected_date = this.$moment(this.query.selected_date).add(-1, 'days').format('YYYY-MM-DD');
      }
    }, 

    handleShowPaymentModal(rsvId) {
      this.selectedRsv = this.reservations.find(el => el.id == rsvId);
      this.form = {
        payments: { ...this.form_tmp.payments }
      }
      if (this.selectedRsv.payment) {
        this.form = {
          payments: {
            total_price: this.selectedRsv.payment.total_price,
            except_item: this.selectedRsv.payment.except_item,
            except_price: this.selectedRsv.payment.except_price,
            treat_price: 0,
          }
        }
      }
      this.$refs.paymentModal.show()
    }, 

    handleShowRsvModal(rsvId) {
      this.selectedRsv = this.reservations.find(el => el.id == rsvId);
      this.rsv_form = {
        reservations: {
          visit_date: this.selectedRsv.visit_date,
          start_time: this.selectedRsv.start_time,
          end_time: this.selectedRsv.end_time,
          stuff_id: this.selectedRsv.stuff_id,
          rsv_content_id: this.selectedRsv.rsv_content_id,
          menu_id: this.selectedRsv.menu_id,
        },
        patient_infos: {
          name01: this.selectedRsv.patient_info.name01,
          name02: this.selectedRsv.patient_info.name02,
          kana01: this.selectedRsv.patient_info.kana01,
          kana02: this.selectedRsv.patient_info.kana02,
          gender: this.selectedRsv.patient_info.gender,
          phone_number: this.selectedRsv.patient_info.phone_number,
          birthday: this.selectedRsv.patient_info.birthday,
        }
      }
      this.$refs.rsvModal.show()
    },

    handleEditRsv() {
      this.isEditing = true;
    },

    handleUpdateRsv() {
      this.$store.dispatch('state/setIsLoading')
      axios.put(`/api/clinic/reservations/${this.selectedRsv.id}/with-user-info`, this.rsv_form)
        .then(res => {
          this.isEditing = false;
          this.$refs.rsvModal.hide()
          let rsv = res.data.reservation
          this.reservations = this.reservations.map(el => {
            if (el.id == rsv.id) {
              return rsv
            }
            return el
          })
          this.$swal({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            title: '登録しました。',
            icon: 'success',
          })
          this.$store.dispatch('state/removeIsLoading')
        })
        .catch(error => {
          this.errors = { ...error.response.data.errors }
          this.$store.dispatch('state/removeIsLoading')
        })
    },

    handleSavePayment() {
      this.$store.dispatch('state/setIsLoading')
      this.form.payments.treat_price = this.treat_price
      axios.post(`/api/clinic/reservations/${this.selectedRsv.id}/pay`, this.form)
        .then(res => {
          this.$refs.paymentModal.hide()
          this.$store.dispatch('state/removeIsLoading')
          this.getData()
        })
        .catch(error => {
          this.errors = { ...error.response.data.errors }
          this.$store.dispatch('state/removeIsLoading')
        })
    },

    handleModalClose() {
      this.isEditing = false
      this.errors = undefined
    },

    handlePaginate(pageNum) {
      this.query = {
        ...this.query,
        page: pageNum,
      }
      this.getData()
    },
  },

  filters: {
    rsv_content_name(value) {
      if (value) return value.name;

      return '';
    }
  }
}
</script>

<style scoped>
.payment-use-point {
  padding-top: 10px;
}
</style>
