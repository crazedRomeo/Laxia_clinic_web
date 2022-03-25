<template>
  <div class="main-in">
    <div class="main-content">
      <div class="date-pick">					
        <p><input type="date" name=""> ~ <input type="date" name=""></p>
        <p class="price">{{ $t('総決済額') }} : {{ total | currency }}</p>
      </div>
      <div class="tab-content">
        <table class="task-list">
          <thead>
            <tr>
              <th>{{ $t('氏名') }}</th>
              <th>{{ $t('診断日時') }}</th>
              <th>{{ $t('予約内容') }}</th>
              <th>{{ $t('担当者') }}</th>
              <th>{{ $t('利用ポイント') }}</th>
              <th>{{ $t('支払い金額') }}</th>
            </tr>
          </thead>
          <tbody v-if="payments.length > 0">
            <tr class="history-list" v-for="payment in payments" :key="payment.id">
              <td>
              {{ payment.reservation.patient.kana }}
              </td>
              <td>{{ payment.reservation.visit_date | formatDateWithDay }}
                  <br>
                 {{ payment.reservation.start_time | formatTime }}
              </td>
              <td>{{ payment.reservation.hope_treat ? hope_treat_types[payment.reservation.hope_treat] : '' }}</td>
              <td>{{ payment.reservation.doctor ? payment.reservation.doctor.kata_name : '' }}</td>
              <td>{{ payment.reservation.use_point.toLocaleString() }}</td>
              <td>{{ payment.total_price | currency }}</td>
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
</template>

<script>
import axios from 'axios'
import { mapGetters } from 'vuex'

export default {
  middleware: 'auth',

  data() {
    return {
      payments: [],
      query: {
        per_page: 20,
        page: 1,
        // start_time: "",
        // start_time: "",
      },
      pageInfo: undefined,
      total: 0,
    }
  },
  
  computed: {
    ...mapGetters({
      hope_treat_types: 'constant/hope_treat_types',
    }),
  },

  mounted() {
    this.getData();
  },

  methods: {
    getData() {
      this.$store.dispatch('state/setIsLoading')
      const qs = this.$utils.getQueryString(this.query)
      axios.get(`/api/clinic/payments?${qs}`)
        .then(res => {
          this.payments = res.data.payments.data;
          this.total = res.data.sum
          this.pageInfo = {
            last_page: res.data.payments.last_page,
          }
          this.$store.dispatch('state/removeIsLoading')
        })
        .catch(error => {
          this.$store.dispatch('state/removeIsLoading')
        })
    },

    handlePaginate(pageNum) {
      this.query = {
        ...this.query,
        page: pageNum,
      }
      this.getData()
    },
  }
}
</script>

<style scoped>
</style>
