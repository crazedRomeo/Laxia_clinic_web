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
            <tr v-for="payment in payments" :key="payment.id">
              <td>
                <small>{{ payment.reservation.patient_info.kana }}</small>
                <!-- <br>
                {{ payment.reservation.patient_info.name }} -->
              </td>
              <td>{{ payment.reservation.visit_date | formatDateWithDay }}
                  <br>
                 {{ payment.reservation.end_time | formatTime }}</td>
              <td>{{ payment.reservation.rsv_content ? payment.reservation.rsv_content.name : '' }}</td>
              <td>{{ payment.reservation.menu ? payment.reservation.menu.name : '' }}</td>
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

export default {
  middleware: 'auth',

  data() {
    return {
      payments: [],
      query: {
        per_page: 20,
        page: 1,
        start_time: "",
        start_time: "",
      },
      pageInfo: undefined,
      total: 0,
    }
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
