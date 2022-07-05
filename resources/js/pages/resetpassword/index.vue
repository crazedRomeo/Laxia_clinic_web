 <template>
  <div v-if="isloadingPage" class="main-in resetpw-in">
    <div class="main-content resetpw-content">
      <div class="page-title">アカウント設定</div>
      <div class="page-notice-msg">アカウントID、メールアドレス、パスワードに関する情報はこちらで変更することができます。</div>

      <div class="label-title">アカウントID</div>
      <div class="p-content p-grp">{{ clinic.user_name }}</div>

      <div class="label-title">メールアドレス</div>
      <div class="row p-grp">
        <div class="col-md-4 col-12 d-flex align-items-center">
          <p class="p-content">{{ clinic.email }}</p>
        </div>
        <div class="col-md-6 col-12 mt-sm-0 mt-2">
          <button class="bootstrap-btn btn btn-secondary-2"  @click="handleEmail">変更する</button>
        </div>
      </div>

      <div class="label-title">パスワード</div>
      <div class="row p-grp">
        <div class="col-md-4 col-12 d-flex align-items-center">
          <p class="p-content">●●●●●●●</p>
        </div>
        <div class="col-md-6 col-12 mt-sm-0 mt-2">
          <button class="bootstrap-btn btn btn-secondary-2"  @click="handlePassword">変更する</button>
        </div>
      </div>
    </div>
    <form-modal
      ref="emailModal"
      id="email-modal"
      :title="modalInfo.title"
    >
      <div v-if="isEmailModal" class="main-modal">
        <div class="profile-dialog-container">
          <div class="input-con">
            <label>{{ $t('新しいメールアドレス') }}</label>
            <input class="form-control" type="text" v-model="form.email" @keyup="add_todo_keyup"
              :class="{'is-invalid' : errors && errors['email'] && (form.email == '' || show_email_error) }"
            />
            <div v-if="errors && errors['email']" class="error invalid-feedback">{{ errors['email'][0] }}</div>
          </div>
          <div class="btn-grp">
              <button class="btn btn-notify-secondary btn-sm"  @click="handleCancelEmail">キャンセル</button>
              <button class="btn btn-notify-primary btn-sm" :class="(isChangeEmail) ? 'btn-notify-primary-enable' : ''"  @click="handleUpdateEmail">メールアドレスを変更</button>
          </div>
        </div>
      </div>
    </form-modal>

    <form-modal
      ref="passwordModal"
      id="password-modal"
      :title="modalInfo.title"
    >
      <div v-if="isPasswordModal" class="main-modal">
        <div class="profile-dialog-container">

          <div class="item-con">
            <div class="label lable-grp">
              <span class="label-title">{{ $t('現在のパスワード') }}</span>
              <span class="label-sm-title">{{ $t('パスワードを忘れた場合') }}</span>
            </div>
            <div class="input-group">
              <input  v-if="'text' === curPwType" type="text" class="form-control custom-pw-form-control" v-model="passwordForm.current_password"/>
              <input v-else type="password" class="form-control custom-pw-form-control" v-model="passwordForm.current_password" />
              <i class="bi bi-eye-fill" id="toggleCurPassword" @click="showCurPassword"></i>
            </div>
            <div v-if="errors && errors.current_password" class="error invalid-feedback-custom">{{ errors.current_password[0] }}</div>
          </div>

          <div class="item-con">
            <span class="label label-title">{{ $t('新しいパスワード') }}</span>
            <div class="input-group">
              <input  v-if="'text' === newPwType" type="text" class="form-control" v-model="passwordForm.new_password"/>
              <input v-else type="password" class="form-control" v-model="passwordForm.new_password" />
              <i class="bi bi-eye-fill" id="toggleNewPassword" @click="showNewPassword"></i>
            </div>
            <div v-if="errors && errors.new_password" class="error invalid-feedback-custom">{{ errors.new_password[0] }}</div>
          </div>

          <div class="item-con">
            <span class="label label-title">{{ $t('新しいパスワード(再入力)') }}</span>
            <input class="form-control mt-2" type="password" v-model="passwordForm.new_password_confirmation" />
            <div v-if="errors && errors.new_password_confirmation" class="error invalid-feedback-custom">{{ errors.new_password_confirmation[0] }}</div>
          </div>

          <div class="btn-grp">
            <button class="btn btn-notify-secondary btn-sm"  @click="handleCancelPassword">キャンセル</button>
            <button class="btn btn-notify-primary btn-sm"  @click="handleUpdatePassword">メールアドレスを変更</button>
          </div>
        </div>
      </div>
    </form-modal>

  </div>
</template>

<script>
import axios from 'axios'
import { mapGetters } from 'vuex'

export default {
  middleware: 'auth',

  computed: {
    ...mapGetters({
      user: 'auth/user',
    })
  },

  watch: {
    'form.email': function(newVal, oldVal) {
      if(newVal) {
        this.show_email_error = false
      } else {
        this.show_email_error = true
      }
    }
  },
  mounted () {
    this.getData();
  },

  data() {
    return {
      isloadingPage: false,
      isEmailModal: false,
      isPasswordModal: false,
      isChangeEmail: false,
      clinic: undefined,
      modalInfo: {
        title: '',
        confirmBtnTitle: '',
      },
      pageInfo: undefined,
      form: undefined,
      errors: undefined,
      passwordForm: {
        current_password:'',
        new_password:'',
        new_password_confirmation: ''
      },

      curPwType: 'password',
      newPwType: 'password',
      confirmPwType: 'password',

      show_email_error: false,
    }
  },


  methods: {
    getData(){
      this.$store.dispatch('state/setIsLoading')
      axios.get(`/api/clinic/getInfo`)
        .then(res => {
          this.$store.dispatch('state/removeIsLoading')
          this.clinic = res.data.clinic
          this.isloadingPage = true
        })
        .catch(error => {
          this.$store.dispatch('state/removeIsLoading')
        })
    },

    handleEmail() {
      this.modalInfo = {
        title: 'メールアドレスを変更',
        confirmBtnTitle: '検索'
      }
      this.form = {...this.clinic}

      this.isEmailModal = true
      this.$refs.emailModal.show();
    },

    handleCancelEmail(){
      this.$refs.emailModal.hide();
    },

    handleUpdateEmail(){
      this.$store.dispatch('state/setIsLoading')
      axios.post(`/api/clinic/update/email`, this.form)
        .then(res => {
          this.$store.dispatch('state/removeIsLoading')
          this.clinic = res.data.data
          this.isEmailModal = false
      this.$refs.emailModal.hide();
        })
        .catch(error => {
          this.$store.dispatch('state/removeIsLoading')
          this.errors = { ...error.response.data.errors }
        })
      // this.isEmailModal = false
      // this.$refs.emailModal.hide();
    },

    handlePassword() {
      this.modalInfo = {
        title: 'パスワードを変更',
        confirmBtnTitle: '検索'
      }
      this.isPasswordModal = true
      this.$refs.passwordModal.show();
    },

    handleUpdatePassword(){
      this.$store.dispatch('state/setIsLoading')
      axios.post(`/api/clinic/update/password`, this.passwordForm)
        .then(res => {
          this.$store.dispatch('state/removeIsLoading')
          this.$refs.passwordModal.hide();
        })
        .catch(error => {
          this.$store.dispatch('state/removeIsLoading')
          this.errors = {...error.response.data.errors}
        })
    },

    handleCancelPassword(){
      this.$refs.passwordModal.hide()
    },

    showCurPassword(){
      if(this.curPwType === 'text'){
        this.curPwType = 'password'
      }else{
        this.curPwType = 'text'
      }
      const toggleCurPassword = document.querySelector('#toggleCurPassword');
      toggleCurPassword.classList.toggle('bi-eye-slash');
    },
    showNewPassword(){
      if(this.newPwType === 'text'){
        this.newPwType = 'password'
      }else{
        this.newPwType = 'text'
      }
      const toggleNewPassword = document.querySelector('#toggleNewPassword');
      toggleNewPassword.classList.toggle('bi-eye-slash');
    },
    add_todo_keyup(e){
      // if (e.key == 'Enter') {
      // }
      if(e.target.value.length > 0){
        this.isChangeEmail = true;
      }else{
        this.isChangeEmail = false;
      }
    }
  }
}
</script>

<style scoped>

  .page-title{
    font-size: 24px;
    font-weight: 800;
  }
  .page-notice-msg{
    font-size: 14px;
    letter-spacing: 2px;
    font-weight: 600;
  }

  .divider{
    height: 50px;
  }
  .p-title{
    letter-spacing: 5px;
  }
  .p-content{
    font-size: 18px;
    font-weight: 600;
    letter-spacing: 2px;
  }

  .profile-dialog-container{
    padding: 0 30px;
  }
  .main-modal i {
    width: 20px;
    height: 13px;
    position: absolute;
    right: 8px;
    top: 8px;
    font-size: 16px;
    cursor: pointer;
    z-index: 100;
  }
  .label-sm-title{
    font-size: 12px;
    font-weight: bold;
  }

</style>
