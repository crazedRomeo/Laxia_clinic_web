<template>
  <div v-if="is_master_loaded" class="main-in">
    <div class="main-content">
      <div class="date-pick">
        <button @click="handleSelectDate('prev')">
          <img src="/img/date-prev.svg" />
        </button>
        <p>
          <input type="date" v-model="query.selected_date" /><span
            class="select-current-date-btn"
            @click="handleSelectDate('current')"
            >{{ $t("今日") }}</span
          >
        </p>
        <button @click="handleSelectDate('next')">
          <img src="/img/date-next.svg" />
        </button>
      </div>
      <div class="tab-content">
        <table class="task-list">
          <thead>
            <tr>
              <th>{{ $t("来院日時") }}</th>
              <th>{{ $t("診断時間") }}</th>
              <th>{{ $t("氏名") }}</th>
              <th>{{ $t("性別") }}</th>
              <th>{{ $t("担当医師") }}</th>
              <th>{{ $t("予約内容") }}</th>
              <th>{{ $t("詳細") }}</th>
              <th>{{ $t("支払い") }}</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, index) in reservations" :key="index">
              <td>{{ item.visit_date | formatDateWithDay }}</td>
              <td>{{ item.start_time_without_sec }}</td>
              <td>
                {{ item.patient ? item.patient.kana : "" }}
              </td>
              <td>
                {{
                  item.patient
                    ? item.patient.gender
                    : "" &&
                      gender_types[item.patient ? item.patient.gender : ""]
                }}
              </td>
              <td>{{ item.doctor ? item.doctor.name : "" }}</td>
              <td>
                {{ item.hope_treat ? hope_treat_types[item.hope_treat] : "" }}
              </td>
              <td>
                <button
                  type="button"
                  class="btn-primary normal-btn"
                  @click="handleShowRsvModal(item.id)"
                >
                  {{ $t("詳細") }}
                </button>
              </td>
              <td>
                <button
                  type="button"
                  class="btn-primary normal-btn"
                  @click="handleShowPaymentModal(item.id)"
                >
                  {{ $t("決済") }}
                </button>
              </td>
            </tr>
          </tbody>
        </table>
        <pagination
          v-if="pageInfo"
          :page="query.page"
          :page-count="pageInfo.last_page"
          :click-handler="handlePaginate"
        />
      </div>
    </div>
    <form-modal ref="rsvModal" id="reservation-modal" :title="$t('予約内容')">
      <div v-if="!isEditing">
        <div v-if="selectedRsv" class="reserve-content">
          <ul>
            <li>
              <div>{{ $t("診察者") }}</div>
              <div class="rsv-main-content">
                <div>
                  <span>{{ $t("名前") }}</span>
                  {{ selectedRsv.patient ? selectedRsv.patient.kana : "" }}
                </div>
                <div>
                  <span>{{ $t("性別") }}</span>
                  {{
                    selectedRsv.patient
                      ? selectedRsv.patient.gender
                      : "" &&
                        gender_types[
                          selectedRsv.patient ? selectedRsv.patient.gender : ""
                        ]
                  }}
                </div>
                <div>
                  <span>{{ $t("年齢") }}</span>
                  {{ selectedRsv.patient? selectedRsv.patient.age : '' }}
                </div>
                <div>
                  <span>{{ $t("電話番号") }}</span>
                  {{ selectedRsv.patient? selectedRsv.patient.phone_number : ''}}
                </div>
                <div>
                  <span>{{ $t("生年月日") }}</span>
                  {{ selectedRsv.patient? selectedRsv.patient.birthday : ''| formatDate }}
                </div>
              </div>
            </li>
            <li>
              <div>{{ $t("予定日") }}</div>
              <div class="rsv-main-content">
                <div>
                  <span>{{ $t("日にち") }}</span>
                  {{ selectedRsv.visit_date | formatDateWithDay }}
                </div>
                <div>
                  <span>{{ $t("診察時間") }}</span>
                  {{ selectedRsv.start_time_without_sec }}
                </div>
              </div>
            </li>
            <li>
              <div>{{ $t("担当者") }}</div>
              <div class="rsv-main-content">
                <div>
                  <span>{{ $t("医師") }}</span>
                  {{ selectedRsv.doctor && selectedRsv.doctor.name }}
                </div>
                <div>
                  <span>{{ $t("予約内容") }}</span>
                  {{
                    selectedRsv.hope_treat &&
                    hope_treat_types[selectedRsv.hope_treat]
                  }}
                </div>
              </div>
            </li>
          </ul>
        </div>
        <div class="btn-payment-wrapper">
          <div class="btn-wrapper">
            <button
              type="button"
              class="btn btn-danger"
              @click="handleCancelRsv"
            >
              {{ $t("予約をキャンセル") }}
            </button>
          </div>
          <div class="btn-wrapper">
            <button
              type="button"
              class="btn btn-primary"
              @click="handleEditRsv"
            >
              {{ $t("予約を編集する") }}
            </button>
          </div>
        </div>
      </div>
      <div v-else>
        <div v-if="selectedRsv" class="reserve-content">
          <ul>
            <li>
              <div>{{ $t("診察者") }}</div>
              <div class="rsv-main-content">
                <div>
                  <span>{{ $t("名前") }}</span>
                  {{ selectedRsv.patient ? selectedRsv.patient.kana : "" }}
                </div>
                <div>
                  <span>{{ $t("性別") }}</span>
                  {{
                    selectedRsv.patient
                      ? selectedRsv.patient.gender
                      : "" &&
                        gender_types[
                          selectedRsv.patient ? selectedRsv.patient.gender : ""
                        ]
                  }}
                </div>
                <div>
                  <span>{{ $t("年齢") }}</span>
                  {{ selectedRsv.patient ? selectedRsv.patient.age : ''}}
                </div>
                <div>
                  <span>{{ $t("生年月日") }}</span>
                  {{ selectedRsv.patient? selectedRsv.patient.birthday : '' | formatDate }}
                </div>
                <div>
                  <span>{{ $t("電話番号") }}</span>
                  {{ selectedRsv.patient? selectedRsv.patient.phone_number : ''}}
                </div>
              </div>
            </li>
            <li>
              <div>{{ $t("予約日") }}</div>
              <div class="rsv-main-content2">
                <div>
                  <span>{{ $t("日にち") }}</span>
                  <v-date-picker
                    class="h-auto"
                    v-model="rsv_form.reservations.visit_date"
                    :masks="{ L: 'YYYY-MM-DD' }"
                    :attributes="attrs"
                    :class="{'is-invalid' : errors && errors['reservations.visit_date'] && rsv_form.reservations.visit_date == null}"
                  >
                    <template v-slot="{ inputValue, inputEvents }">
                      <input
                        class="
                          px-2
                          py-1
                          border
                          rounded
                          focus:outline-none focus:border-blue-300
                        "
                        :value="inputValue"
                        v-on="inputEvents"
                      />
                    </template>
                  </v-date-picker>
                  <div
                    v-if="errors && errors['reservations.visit_date']"
                    class="error invalid-feedback"
                  >
                    {{ errors["reservations.visit_date"][0] }}
                  </div>
                </div>
                <div class="time-picker-content">
                  <span>{{ $t("診断時間") }}</span>
                  <vue-timepicker
                    fixed-dropdown-button
                    placeholder=" "
                    v-model="timePicker_start_time"
                    :class="{
                      'is-invalid': errors && errors['reservations.start_time'] && (timePicker_start_time.HH == '' || timePicker_start_time.mm == ''),
                    }"
                    :hour-range="[[6, 23]]"
                    :minute-interval="15"
                  >
                    <template v-slot:dropdownButton>
                      <img src="/img/polygon.svg" />
                    </template>
                  </vue-timepicker>
                  <div
                    v-if="errors && errors['reservations.start_time']"
                    class="error invalid-feedback"
                  >
                    {{ errors["reservations.start_time"][0] }}
                  </div>
                </div>
              </div>
            </li>
            <li>
              <div>{{ $t("担当者") }}</div>
              <div class="rsv-main-content2">
                <div>
                  <span>{{ $t("医師・スタッフ") }}</span>
                  <!-- <select v-model="rsv_form.reservations.doctor_id" :class="{'is-invalid' : errors && errors['reservations.doctor_id'] }">
                    <option v-for="(doctor) in doctors" :key="doctor.id" :value="doctor.id">{{ doctor.kata_name }}</option>
                  </select> -->
                  <c-select
                    :options="doctors"
                    :textkey="'kata_name'"
                    :valkey="'id'"
                    :emptyable="true"
                    :default="rsv_form.reservations.doctor_id"
                    class="select"
                    ref="doctorSelect"
                    @change="selectedDoctor"
                    :class="{'is-invalid' : errors && errors['reservations.doctor_id'] && rsv_form.reservations.doctor_id == null}"
                  />
                  <div
                    v-if="errors && errors['reservations.doctor_id']"
                    class="error invalid-feedback"
                  >
                    {{ errors["reservations.doctor_id"][0] }}
                  </div>
                </div>
                <div>
                  <span>{{ $t("予約内容") }}</span>
                  <!-- <select v-model="rsv_form.reservations.hope_treat" :class="{'is-invalid' : errors && errors['reservations.hope_treat'] }">
                    <option v-for="(name, id) in hope_treat_types" :key="id" :value="id">{{ name }}</option>
                  </select> -->
                  <c-enum-select
                    :options="hope_treat_types"
                    :emptyable="true"
                    :default="rsv_form.reservations.hope_treat"
                    class="select"
                    ref="hopeTreatSelect"
                    @change="selectedHopeTreat"
                    :class="{'is-invalid' : errors && errors['reservations.hope_treat'] && rsv_form.reservations.hope_treat == null}"
                  />
                  <div
                    v-if="errors && errors['reservations.hope_treat']"
                    class="error invalid-feedback"
                  >
                    {{ errors["reservations.hope_treat"][0] }}
                  </div>
                </div>
              </div>
            </li>
          </ul>
        </div>
        <div class="btn-wrapper">
          <button
            type="button"
            class="btn btn-primary"
            @click="handleUpdateRsv"
          >
            {{ $t("編集を完了する") }}
          </button>
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
            <span>{{
              selectedRsv.patient ? selectedRsv.patient.kana : ""
            }}</span>
          </div>
          <div>
            <span></span>
            {{ selectedRsv.patient? selectedRsv.patient.age : ''}}歳/{{
              selectedRsv.patient
                ? selectedRsv.patient.gender
                : "" &&
                  gender_types[
                    selectedRsv.patient ? selectedRsv.patient.gender : ""
                  ]
            }}
          </div>
        </div>
        <div class="rsv-summary-content">
          <div>
            <span>{{ $t("来院日時") }}</span>
            {{ selectedRsv.visit_date | formatDateWithDay }}
            {{ selectedRsv.start_time_without_sec }}
          </div>
          <div>
            <span>{{ $t("予約内容") }}</span>
            {{
              selectedRsv.hope_treat && hope_treat_types[selectedRsv.hope_treat]
            }}
          </div>
          <div>
            <span>{{ $t("担当者") }}</span>
            {{ selectedRsv.doctor && selectedRsv.doctor.kata_name }}
          </div>
        </div>

        <div>{{ $t("会計金額") }}</div>
        <div class="treat-calc--wrapper">
          <div>
            <div>
              <span>{{ $t("合計金額") }}({{ $t("税抜") }})</span>
              <input
                type="number"
                name=""
                v-model="form.payments.total_price"
                min="1"
                :class="{
                  'is-invalid': errors && errors['payments.total_price'] && form.payments.total_price == '',
                }"
              />
              <div
                v-if="errors && errors['payments.total_price']"
                class="error invalid-feedback"
              >
                {{ errors["payments.total_price"][0] }}
              </div>
            </div>
          </div>
          <span class="operator">　ー　</span>
          <div>
            <div>
              <span>{{ $t("控除金額") }}({{ $t("税抜") }})</span>
              <input
                type="number"
                name=""
                v-model="form.payments.except_price"
                min="0"
                :class="{
                  'is-invalid': errors && errors['payments.except_price'] && form.payments.except_price == '',
                }"
              />
              <div
                v-if="errors && errors['payments.except_price']"
                class="error invalid-feedback"
              >
                {{ errors["payments.except_price"][0] }}
              </div>
            </div>
          </div>
          <span class="operator">　ー　</span>
          <div>
            <div>
              <span>{{ $t("利用ポイント") }}</span>
              <p class="payment-use-point">{{ selectedRsv.use_point }}</p>
            </div>
          </div>
          <span class="operator"> = </span>
          <div>
            <div>
              <span>{{ $t("施術金額") }}</span>
              <input
                class="payment-result"
                type="text"
                name=""
                disabled
                v-model="treat_price"
              />
            </div>
          </div>
        </div>
      </div>
      <div class="btn-wrapper">
        <button
          type="button"
          class="btn btn-primary"
          @click="handleSavePayment"
        >
          {{ $t("成果を決定する") }}
        </button>
      </div>
    </form-modal>
  </div>
</template>

<script>
import axios from "axios";
import { mapGetters } from "vuex";

export default {
  middleware: "auth",

  data() {
    return {
      // 予約ステータスが「調整完了」である予約一覧取得
      reservations: [],
      doctors: [],
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
          total_price: "",
          except_item: "",
          except_price: "",
          treat_price: "",
        },
      },
      rsv_form: undefined,
      rsv_form_tmp: {
        reservations: {
          visit_date: "",
          start_time: "",
          end_time: "",
          doctor_id: "",
          hope_treat: "",
        },
      },
      pageInfo: undefined,
      errors: undefined,
      attrs: [
        {
          key: "today",
          highlight: {
            color: "gray",
            fillMode: "light",
          },
          dates: new Date(),
        },
      ],
      timePicker_start_time: {
        HH: '',
        mm: ''
      },
    };
  },

  mounted() {
    this.getCommonData();
    this.getData();
  },

  computed: {
    ...mapGetters({
      is_master_loaded: "state/is_master_loaded",
      gender_types: "constant/gender_types",
      hope_treat_types: "constant/hope_treat_types",
    }),
    treat_price: function () {
      return (
        this.form.payments.total_price -
        this.form.payments.except_price -
        this.selectedRsv.use_point
      );
    },
    years() {
      const year = new Date().getFullYear();
      const length = 40;
      return Array.from(
        { length: length },
        (value, index) => year - length + index
      );
    },
  },

  methods: {
    getCommonData() {
      this.$store.dispatch("state/setIsLoading");

      axios
        .get(`/api/clinic/payments/common_data`)
        .then((res) => {
          this.doctors = res.data.doctors;

          this.$store.dispatch("state/removeIsLoading");
        })
        .catch((error) => {
          this.$store.dispatch("state/removeIsLoading");
        });
    },
    getData() {
      this.$store.dispatch("state/setIsLoading");
      const qs = this.$utils.getQueryString(this.query);
      axios
        .get(`/api/clinic/reservations/payments?${qs}`)
        .then((res) => {
          this.reservations = res.data.reservations.data;
          this.pageInfo = {
            last_page: res.data.reservations.last_page,
          };
          this.$store.dispatch("state/removeIsLoading");
        })
        .catch((error) => {
          this.$store.dispatch("state/removeIsLoading");
        });
    },

    handleSelectDate(param) {
      if (param == "current") {
        this.query.selected_date = this.$moment().format("YYYY-MM-DD");
      } else if (param == "next") {
        this.query.selected_date = this.$moment(this.query.selected_date)
          .add(1, "days")
          .format("YYYY-MM-DD");
      } else if (param == "prev") {
        this.query.selected_date = this.$moment(this.query.selected_date)
          .add(-1, "days")
          .format("YYYY-MM-DD");
      }
    },

    handleShowPaymentModal(rsvId) {
      this.selectedRsv = this.reservations.find((el) => el.id == rsvId);
      this.form = {
        payments: { ...this.form_tmp.payments },
      };
      if (this.selectedRsv.payments !== null) {
        this.form = {
          payments: {
            total_price: this.selectedRsv.payments.total_price,
            except_item: this.selectedRsv.payments.except_item,
            except_price: this.selectedRsv.payments.except_price,
            treat_price: 0,
          },
        };
      } else {
        this.selectedRsv = {
          ...this.selectedRsv,
          payments: {
            total_price: "",
            except_item: "",
            except_price: "",
            treat_price: 0,
          },
        };
      }
      this.$refs.paymentModal.show();
    },

    handleShowRsvModal(rsvId) {
      this.selectedRsv = this.reservations.find((el) => el.id == rsvId);
      console.log('hhhhhhhhhhhhhh', this.selectedRsv);
      this.rsv_form = {
        reservations: {
          visit_date: this.selectedRsv.visit_date,
          start_time: this.selectedRsv.start_time,
          end_time: this.selectedRsv.end_time,
          doctor_id: this.selectedRsv.doctor_id,
          hope_treat: this.selectedRsv.hope_treat,
        },
      };

      if(this.rsv_form.reservations.start_time != null) {
        var arr = this.rsv_form.reservations.start_time.split(':');
        this.timePicker_start_time.HH = arr[0];
        this.timePicker_start_time.mm = arr[1];
      }

      this.isEditing = false;
      if (this.$refs.doctorSelect)
        this.$refs.doctorSelect.set(this.rsv_form.reservations.doctor_id);
      if (this.$refs.hopeTreatSelect)
        this.$refs.hopeTreatSelect.set(this.rsv_form.reservations.hope_treat);
      this.$refs.rsvModal.show();
    },

    handleEditRsv() {
      this.isEditing = true;
    },

    handleUpdateRsv() {
      this.$store.dispatch("state/setIsLoading");

      if (this.timePicker_start_time.HH == '' || this.timePicker_start_time.mm == '')
        this.rsv_form.reservations.start_time = null;
      else
        this.rsv_form.reservations.start_time = this.timePicker_start_time.HH + ':' + this.timePicker_start_time.mm;

      if(this.rsv_form.reservations.visit_date != null)
        this.rsv_form.reservations.visit_date = (new Date(this.rsv_form.reservations.visit_date)).toISOString().substring(0, 10);

      axios
        .put(
          `/api/clinic/reservations/${this.selectedRsv.id}/with-user-info`,
          this.rsv_form
        )
        .then((res) => {
          this.isEditing = false;
          this.$refs.rsvModal.hide();
          let rsv = res.data.reservation;

          if (!res.data.reservation.payments) {
            rsv.payments = {
              total_price: "",
              except_item: "",
              except_price: "",
              treat_price: 0,
            };
          }

          this.reservations = this.reservations.map((el) => {
            if (el.id == rsv.id) {
              return rsv;
            }
            return el;
          });
          this.$swal({
            toast: true,
            position: "top-end",
            showConfirmButton: false,
            timer: 3000,
            title: "登録しました。",
            icon: "success",
          });
          this.$store.dispatch("state/removeIsLoading");
        })
        .catch((error) => {
          this.errors = { ...error.response.data.errors };
          this.$store.dispatch("state/removeIsLoading");
        });
    },

    handleSavePayment() {
      this.$store.dispatch("state/setIsLoading");
      this.form.payments.treat_price = this.treat_price;
      axios
        .post(`/api/clinic/reservations/${this.selectedRsv.id}/pay`, this.form)
        .then((res) => {
          this.$refs.paymentModal.hide();
          this.$store.dispatch("state/removeIsLoading");
          this.getData();
        })
        .catch((error) => {
          this.errors = { ...error.response.data.errors };
          this.$store.dispatch("state/removeIsLoading");
        });
    },

    handleModalClose() {
      this.isEditing = false;
      this.errors = undefined;
      this.timePicker_start_time = {
        HH: '',
        mm: ''
      };
    },

    selectedDoctor(selected_option) {
      this.rsv_form.reservations.doctor_id = selected_option
        ? selected_option.id
        : null;
    },

    selectedHopeTreat(selected_option) {
      this.rsv_form.reservations.hope_treat = selected_option;
    },

    handleCancelRsv() {
      this.$store.dispatch("state/setIsLoading");
      axios
        .delete(`/api/clinic/reservations/delete/${this.selectedRsv.id}`)
        .then((res) => {
          if (res.data.status == 1) {
            this.reservations = this.reservations.filter(
              (el) => el.id != res.data.id
            );

            this.$store.dispatch("state/removeIsLoading");
            this.$refs.rsvModal.hide();

            this.$swal({
              toast: true,
              position: "top-end",
              showConfirmButton: false,
              timer: 3000,
              title: "削除。",
              icon: "success",
            });
          } else {
            this.$store.dispatch("state/removeIsLoading");
            this.$refs.rsvModal.hide();
          }
        })
        .catch((error) => {
          this.$refs.rsvModal.hide();
          this.$store.dispatch("state/removeIsLoading");
        });
    },

    handlePaginate(pageNum) {
      this.query = {
        ...this.query,
        page: pageNum,
      };
      this.getData();
    },
  },

  filters: {
    rsv_content_name(value) {
      if (value) return value.name;

      return "";
    },
  },
};
</script>

<style scoped>
.payment-use-point {
  padding-top: 10px;
}
</style>
