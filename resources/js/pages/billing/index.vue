<template>
  <div class="main-in">
    <div class="main-content">
      <div v-if="current" class="payment">
        <div>
          <div>
            <p class="payment-ttl">{{ past_month }}月請求金額</p>
              <div>
                <strong>{{ current.total | currency }}</strong>
              </div>
          </div>
          <div>
            <p class="payment-ttl">{{ past_month }}月払い戻し金額</p>
            <div class="refund-calc">
              <strong>30000円</strong>
            </div>
          </div>
        </div>
        <div>
          <p class="payment-ttl">{{ $t('支払先') }}</p>
          <div class="payment-div">
            <div><span>{{ $t('銀行名') }}</span>：<span>〇〇銀行</span></div>
            <div><span>{{ $t('支店名') }}</span>：<span>〇〇支店</span></div>
            <div><span>{{ $t('口座種類') }}</span>：<span>普通</span></div>
            <div><span>{{ $t('口座番号') }}</span>：<span>11111111</span></div>
            <div><span>{{ $t('口座名義') }}</span>：<span>(カ)ラシア</span></div>
          </div>
        </div>
      </div>
      <div class="past-payment">
        <p class="payment-ttl">{{ $t('過去の支払い') }}</p>
        <table class="task-list payment-list">
          <thead>
            <tr>
              <th>{{ $t('月') }}</th>
              <th>{{ $t('支払い合計金額') }}</th>
              <th>{{ $t('手数料') }}</th>
              <th>{{ $t('システム利用料') }}</th>
              <th>{{ $t('利用ポイント') }}</th>
              <th>{{ $t('請求金額') }}</th>
              <th>{{ $t('PDF') }}</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="item in withdraws" :key="item.id">
              <td>{{ item.month | formatDateWithOutDay }}</td>
              <td>{{ item.price | currency }}</td>
              <td>{{ item.tax }}%</td>
              <td>{{ item.system_fee | currency }}</td>
              <td>{{ 0 }}</td>
              <td>{{ (item.price * item.tax / 100 + item.system_fee) | currency }}</td>
              <td><a href="" download>{{ $t('ダウンロード') }}</a></td>
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
      withdraws: [],
      current: undefined,
      query: {
        per_page: 20,
        page: 1
      },
      pageInfo: undefined,
      past_month: undefined,
    }
  },

  mounted() {
    this.past_month = this.$moment().subtract(1,'months').endOf('month').format('M');
    this.initData();
  },

  methods: {
    initData() {
      this.$store.dispatch('state/setIsLoading')
      const qs = this.$utils.getQueryString(this.query)
      const ym = this.$moment().subtract(1,'months').endOf('month').format('YYYY-MM');
      return Promise.all([
        axios.get(`/api/clinic/withdarws?${qs}`),
        axios.get(`/api/clinic/withdarws/${ym}`)
      ]).then(([res1, res2]) => {
        this.withdraws = res1.data.withdraws.data
        this.pageInfo = {
          last_page: res1.data.withdraws.last_page,
        }
        this.current = res2.data.withdraw
      }).finally(() => {
        this.$store.dispatch('state/removeIsLoading')
      });
    },

    getHistoryData() {
      this.$store.dispatch('state/setIsLoading')
      const qs = this.$utils.getQueryString(this.query)
      axios.get(`/api/clinic/withdarws?${qs}`)
        .then(res => {
          this.withdraws = res.data.withdraws.data
        })
        .catch(error => {
        })
        .finally(() => {
          this.$store.dispatch('state/removeIsLoading')
        });
    },

    handlePaginate(pageNum) {
      this.query = {
        ...this.query,
        page: pageNum,
      }
      this.getHistoryData()
    },
  }
}
</script>

<style scoped>
</style>
