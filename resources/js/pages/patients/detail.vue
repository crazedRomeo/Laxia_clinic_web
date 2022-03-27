<template>
  <div v-if="is_master_loaded" class="main-in">
    <div class="main-content">
      <div v-if="patientInfo" class="u-content">
        <div v-if="!isEditing">
          <div class="u-number">
            <p class="payment-ttl">{{ $t('カルテ番号') }} {{ patientInfo.id }}</p>
            <button class="btn u-edit-btn" @click="handleEditPatientProfile">{{ $t('個人情報を編集') }}</button>
          </div>
          <div class="u-name">
            <span>{{ patientInfo.kana }}</span>
            {{ patientInfo.name }}
          </div>
          <div class="u-info">
            <div>
              <small></small><br>
              {{ patientInfo.birthday | formatDate }}
            </div>
            <div>
              <small></small><br>
              {{ patientInfo.age }}{{ $t('代') }}/{{ gender_types[patientInfo.gender] }}
            </div>
            <div>
              <small>{{ $t('電話番号') }}</small><br>
              {{ patientInfo.phone_number }}
            </div>
          </div>
          <div class="u-textarea">
            <span>{{ $t('患者メモ') }}</span>
            <div class="clinic-memo">{{ patientInfo.memo }}</div>
          </div>
        </div>
        <div v-else>
					<div class="u-number">
						<p class="payment-ttl">{{ $t('カルテ番号') }} {{ patientInfo.id }}</p>
            <div class="u-edit-btn--wrapper">
              <button class="btn u-edit-btn" @click="handleSavePatientProfile">{{ $t('編集を完了') }}</button>
              <button class="btn u-edit-btn u-edit-btn--reserve" @click="handleEditCancel">{{ $t('キャンセル') }}</button>
            </div>
					</div>
					<div class="u-info u-name-edit">
						<div>
							<small>{{ $t('氏名') }}({{ $t('漢字') }})</small><br>
              <div class="name-wrapper d-flex">
                <div>
                  <input type="text" v-model="form.patientInfos.name01" :class="{'is-invalid' : errors && errors['patientInfos.name01'] }">
                  <div v-if="errors && errors['patientInfos.name01']" class="error invalid-feedback">{{ errors['patientInfos.name01'][0] }}</div>
                </div>
                <div>
                  <input type="text" v-model="form.patientInfos.name02" :class="{'is-invalid' : errors && errors['patientInfos.name02'] }">
                  <div v-if="errors && errors['patientInfos.name02']" class="error invalid-feedback">{{ errors['patientInfos.name02'][0] }}</div>
                </div>
              </div>
						</div>
						<div>
							<small>{{ $t('シメイ') }}({{ $t('カタカナ') }})</small><br>
              <div class="name-wrapper d-flex">
                <div>
                  <input type="text" v-model="form.patientInfos.kana01" :class="{'is-invalid' : errors && errors['patientInfos.kana01'] }">
                  <div v-if="errors && errors['patientInfos.kana01']" class="error invalid-feedback">{{ errors['patientInfos.kana01'][0] }}</div>
                </div>
                <div>  
                  <input type="text" v-model="form.patientInfos.kana02" :class="{'is-invalid' : errors && errors['patientInfos.kana02'] }">
                  <div v-if="errors && errors['patientInfos.kana02']" class="error invalid-feedback">{{ errors['patientInfos.kana02'][0] }}</div>
                </div>
              </div>
						</div>
					</div>
					<div class="u-info u-info-edit">
						<div>
							<small>{{ $t('生年月日') }}</small><br>
							<input type="date" v-model="form.patientInfos.birthday" :class="{'is-invalid' : errors && errors['patientInfos.birthday'] }" >
              <div v-if="errors && errors['patientInfos.birthday']" class="error invalid-feedback">{{ errors['patientInfos.birthday'][0] }}</div>
						</div>
					</div>
					<div class="u-info u-info-edit">
						<div>
							<small>{{ $t('性別') }}</small><br>
							<select v-model="form.patientInfos.gender" :class="{'is-invalid' : errors && errors['patientInfos.gender'] }">
								<option v-for="(gender, index) in gender_types" :key="index" :value="index">{{ gender }}</option>
							</select>
              <div v-if="errors && errors['patientInfos.gender']" class="error invalid-feedback">{{ errors['patientInfos.gender'][0] }}</div>
						</div>
						<div>
							<small>{{ $t('電話番号') }}</small><br>
							<input type="text" v-model="form.patientInfos.phone_number" :class="{'is-invalid' : errors && errors['patientInfos.phone_number'] }">
              <div v-if="errors && errors['patientInfos.phone_number']" class="error invalid-feedback">{{ errors['patientInfos.phone_number'][0] }}</div>
						</div>
					</div>
					<div class="u-textarea">
						<span>{{ $t('患者メモ') }}</span>
						<textarea v-model="form.memo" :class="{'is-invalid' : errors && errors['memo'] }"></textarea>
            <div v-if="errors && errors['memo']" class="error invalid-feedback">{{ errors['memo'][0] }}</div>
					</div>
        </div>
        <div class="u-history">
          <p class="payment-ttl">{{ $t('過去の診察履歴') }}</p>
          <table class="task-list">
            <thead>
              <tr>
                <th>{{ $t('来院日時') }}</th>
                <th>{{ $t('予約内容') }}</th>
                <th>{{ $t('背術メニュー') }}</th>
                <th>{{ $t('支払い金額') }}</th>
              </tr>
            </thead>
            <tbody v-if="histories.length > 0">
              <tr v-for="item in histories" :key="item.id">
                <td>{{ item.reservation.visit_date | formatDateWithDay }}</td>
                <td>{{ item.reservation.rsv_content && item.reservation.rsv_content.name }}</td>
                <td>{{ item.reservation.menu && item.reservation.menu.name }}</td>
                <td>{{ item.total_price | currency }}</td>
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
  </div>
</template>

<script>
import axios from 'axios'
import { mapGetters } from 'vuex'

export default {
  middleware: 'auth',

  data() {
    return {
      patientInfoId: undefined,
      searchInfo: undefined,
      patientInfo: undefined,
      form: undefined,
      histories: [],
      isEditing: false,
      pageInfo: undefined,
      errors: undefined,
      query: {
        per_page: 20,
        page: 1,
      },
    }
  },

  computed: mapGetters({
    is_master_loaded: 'state/is_master_loaded',
    gender_types: 'constant/gender_types',
  }),

  mounted() {
    this.patientInfoId = this.$route.params.id;    
    this.initData()
  },

  methods: {
    initData() {
      this.$store.dispatch('state/setIsLoading')
      const qs = this.$utils.getQueryString(this.query)
      return Promise.all([
        axios.get(`/api/clinic/patients/${this.patientInfoId}`),
        axios.get(`/api/clinic/patients/${this.patientInfoId}/payments?${qs}`)
      ]).then(([res1, res2]) => {
        this.patientInfo = res1.data.patientInfo
        this.histories = res2.data.payments.data
        this.pageInfo = {
          last_page: res2.data.payments.last_page,
        }
      }).finally(() => {
        this.$store.dispatch('state/removeIsLoading')
      });
    },

    getRsvHistory() {
      this.$store.dispatch('state/setIsLoading')
      axios.get(`/api/clinic/patients/${this.patientInfoId}/payments`)
        .then(res => {
          this.histories = res.data.payments.data;
          this.$store.dispatch('state/removeIsLoading')
        })
        .catch(error => {
          this.$store.dispatch('state/removeIsLoading')
        })
    }, 

    handleEditPatientProfile() {
      this.form = { 
        patientInfos: { ...this.patientInfo },
        memo: this.patientInfo.memo
      }
      this.isEditing = true;
    },

    handleSavePatientProfile() {
      this.$store.dispatch('state/setIsLoading')
      axios.put(`/api/clinic/patients/${this.patientInfoId}`, this.form)
        .then(res => {
          this.$swal({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            title: '変更しました。',
            icon: 'success',
          })
          this.patientInfo = res.data.patientInfo
          this.isEditing = false
          this.$store.dispatch('state/removeIsLoading')
        })
        .catch(error => {
          this.errors = { ...error.response.data.errors }
          this.$store.dispatch('state/removeIsLoading')
        })
    }, 

    handleEditCancel() {
      this.isEditing = false
      this.errors = undefined
    },

    handlePaginate(pageNum) {
      this.query = {
        ...this.query,
        page: pageNum,
      }
      this.getRsvHistory()
    },
  },
}
</script>

<style scoped>
</style>
