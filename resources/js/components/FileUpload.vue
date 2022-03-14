<template>
  <vue-dropzone
    v-if="dropzoneOptions"
    ref="changePhotoDropzone"
    :id="id"
    :class="{ 'sinlge-file-uploader' : maxFiles == 1, 'multi-files-uploader' : maxFiles > 1 }"
    :options="dropzoneOptions"
    :useCustomSlot="true"
    @vdropzone-file-added="handleFileAdded"
    @vdropzone-success="handleFileSaved"
    @vdropzone-removed-file="hanleFileRemove"
    @vdropzone-error="handleUploadError"
    @vdropzone-queue-complete="handleQueueComplete"
    @vdropzone-complete="handleUploadComplete"
    @vdropzone-complete-multiple="handleMultipleUploadComplete"
    >
    <div v-if="!avatar && !chat" class="dropzone-wrapper">
      <div class="dropzone-in">
        <div class="dropzone-title">
        <svg width="36" height="44" viewBox="0 0 36 44" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M33.8842 8.77281L26.3931 1.7513C25.5896 0.998103 24.5003 0.571289 23.3664 0.571289H5.14314C2.77706 0.579658 0.857422 2.37897 0.857422 4.59673V39.4114C0.857422 41.6291 2.77706 43.4284 5.14314 43.4284H30.8574C33.2235 43.4284 35.1431 41.6291 35.1431 39.4114V11.6182C35.1431 10.5554 34.6878 9.52601 33.8842 8.77281ZM30.5092 11.2919H23.7146V4.92312L30.5092 11.2919ZM5.14314 39.4114V4.59673H19.4289V13.3004C19.4289 14.4135 20.3842 15.3089 21.5717 15.3089H30.8574V39.4114H5.14314ZM8.00028 35.3943H28.0003V24.6821L25.9021 22.7154C25.4824 22.3221 24.8039 22.3221 24.3842 22.7154L16.5717 30.0382L13.0449 26.7325C12.6253 26.3391 11.9467 26.3391 11.5271 26.7325L8.00028 30.0382V35.3943ZM12.286 15.3089C9.91992 15.3089 8.00028 17.1082 8.00028 19.326C8.00028 21.5438 9.91992 23.3431 12.286 23.3431C14.6521 23.3431 16.5717 21.5438 16.5717 19.326C16.5717 17.1082 14.6521 15.3089 12.286 15.3089Z" fill="#5CA3F6"/>
        </svg>

          <!-- <div><img src="/img/file.png"/></div> -->
          <p>{{ $t('写真をドラック & ドロップ') }}</p>
        </div>
      </div>
    </div>
    <button v-if="autoStatus" class="btn btn-file-upload">
      <svg width="19" height="23" viewBox="0 0 19 23" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M0.458008 22.8333H18.5413V20.25H0.458008V22.8333ZM0.458008 9.91667H5.62468V17.6667H13.3747V9.91667H18.5413L9.49968 0.875L0.458008 9.91667Z" fill="#5CA3F6"/>
      </svg>
      <!-- <i class="fas fa-upload"></i>  -->
      <span>{{ $t('写真をアップロード') }}</span>
    </button>
    <div v-if="avatar" class="avatar-wrapper">
      <div>
        <svg width="145" height="145" viewBox="0 0 145 145" fill="none" xmlns="http://www.w3.org/2000/svg">
        <circle cx="72.5" cy="72.5" r="72.5" fill="#F5F5F5"/>
        <path opacity="0.3" d="M99.1381 78.2378C97.3863 74.8907 95.3706 71.8751 93.3869 69.7364C95.8451 66.04 97.2864 61.6093 97.2864 56.8293C97.2829 43.9258 86.8115 33.464 73.8963 33.4604C60.981 33.464 50.5096 43.9258 50.5096 56.8293C50.5096 61.6022 51.951 66.04 54.4092 69.7364C52.422 71.8751 50.4097 74.8943 48.658 78.2378C46.8991 81.6276 45.4399 85.2598 44.8869 88.6782C44.7049 89.8153 44.6193 90.9238 44.6193 91.9968C44.605 95.5684 45.6361 98.7943 47.4449 101.396C50.1564 105.324 54.345 107.805 58.9688 109.352C63.6104 110.892 68.7908 111.534 73.8963 111.537C80.7071 111.52 87.6428 110.422 93.262 107.474C96.0663 105.995 98.553 104.013 100.351 101.396C102.153 98.7943 103.184 95.572 103.177 91.9968C103.177 90.9203 103.091 89.8153 102.906 88.6782C102.356 85.2598 100.897 81.6312 99.1381 78.2378ZM61.905 44.849C64.984 41.7729 69.2011 39.8837 73.8963 39.8837C78.5879 39.8837 82.8121 41.7729 85.8875 44.849C88.9593 47.9252 90.8573 52.142 90.8573 56.8293C90.8538 61.5167 88.9629 65.7299 85.8875 68.8097C82.8085 71.8787 78.5879 73.7714 73.8927 73.7714C69.2011 73.7679 64.9804 71.8787 61.9015 68.8097C58.8261 65.7335 56.9316 61.5202 56.9316 56.8293C56.9352 52.142 58.8296 47.9252 61.905 44.849ZM95.0495 97.7713C93.4511 100.113 90.5719 102.006 86.7865 103.264C83.019 104.522 78.4558 105.121 73.8927 105.114C67.8168 105.132 61.7267 104.034 57.531 101.796C55.4296 100.691 53.817 99.3325 52.7431 97.7641C51.6727 96.1886 51.0555 94.3921 51.0448 92.0003C51.0448 91.2874 51.1055 90.5104 51.2339 89.6798C51.5871 87.3843 52.8108 84.1549 54.3557 81.2106C55.7364 78.5514 57.3883 76.1062 58.7155 74.5842C62.8005 78.0774 68.0987 80.1982 73.8963 80.1982C79.6974 80.1982 84.992 78.0774 89.0806 74.5877C90.4042 76.1098 92.0597 78.5514 93.4404 81.2141C94.9852 84.1584 96.209 87.3879 96.5586 89.6834C96.6906 90.5139 96.7513 91.2839 96.7513 92.0039C96.737 94.3921 96.1234 96.1886 95.0495 97.7713Z" fill="#666E6E"/>
        </svg>
      </div>
      <button class="btn btn-file-upload mt-3"><i class="far fa-file-image"></i> {{ $t('アップロード') }}</button>
    </div>
    <a v-if="chat" class="more-add-image-clicker dropzone-trigger">
      <svg width="25" height="25" viewBox="0 0 25 25" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M9.56015 0H2.04016C1.00616 0 0.169556 0.9 0.169556 2L0.160156 18C0.160156 19.1 0.996756 20 2.03076 20H13.3202C14.3542 20 15.2002 19.1 15.2002 18V6L9.56015 0ZM13.3202 18H2.04016V2H8.62015V7H13.3202V18ZM3.92016 13.01L5.24555 14.42L6.74016 12.84V17H8.62015V12.84L10.1148 14.43L11.4402 13.01L7.68956 9L3.92016 13.01Z" fill="#5F6377"/>
      </svg>
    </a>
  </vue-dropzone>
</template>

<script>
  import { mapGetters } from 'vuex'
  import vue2Dropzone from 'vue2-dropzone'

  export default {
    name: 'FileUpload',

    components: {
      vueDropzone: vue2Dropzone
    },

    props: {
      name: {
        type: String,
        default: undefined
      },
      id: {
        type: String,
        default: 'menu-detail-dropzone'
      },
      photo: {
        type: String,
        default: undefined
      },
      uploadUrl: {
        type: String,
        default: undefined
      },
      maxFiles: {
        type: Number,
        default: 1,
      },
      autoStatus: {
        type: Boolean,
        default: false,
      },
      chat: {
        type: Boolean,
        default: false,
      },
      avatar: {
        type: Boolean,
        default: false,
      }
    },
    
    data() {
      return {
        dropzoneOptions: undefined,
      }
    },

    watch: {
      photo: function(newValue, oldValue) {
        this.setPhoto();
      }
    },

    computed: {
      ...mapGetters({
        token: 'auth/token',
      }),
    },

    mounted() {
      this.dropzoneOptions = {
        acceptedFiles: "image/*",
        url: this.uploadUrl,
        maxFilesize: 15,
        maxFiles: this.maxFiles,
        autoProcessQueue: this.autoStatus,
        headers: {
          "Authorization": `Bearer ${this.token}`
        },
        addRemoveLinks: true,
        dictMaxFilesExceeded: `最高${this.maxFiles}つまで選択してください。`,
        dictFileTooBig: 'ファイルサイズの上限は {{maxFilesize}} MB です\n(size: {{filesize}} MB)',
      }

      this.$nextTick(() => {
        this.setPhoto();
      });
    },

    methods: {
      setPhoto() {
        if (this.photo) {
          this.$refs.changePhotoDropzone.manuallyAddFile({
            size: 1,
            filename: 'menu.png',
            type: "image/png"
          }, this.photo);

          document.querySelector(".dz-preview").classList.add('mal-preview'); 
        }
      },

      handleFileSaved(file, response) {
        this.$emit('file-upload-success', response.photo, this.name)
      },
      
      hanleFileRemove(file, error, xhr) {
        this.$emit('file-removed', this.name)
      },

      handleFileAdded(file, response) {
        this.$emit('file-added', !file.manuallyAdded, this.name)
      },

      handleQueueComplete() {
        this.$emit('queue-complete')
      },

      handleMultipleUploadComplete(response) {
        console.log('Multiple Complete')
      },

      handleUploadComplete(response) {
        console.log('Complete')
      },

      handleUploadError(file, message, xhr) {
        this.$swal({
          title: message,
          icon: 'warning',
        }).then((result) => {
          this.$refs.changePhotoDropzone.removeAllFiles()
        })
      },

      processQueue() {
        this.$refs.changePhotoDropzone.processQueue()
      },

      removeAllFiles() {
        this.$refs.changePhotoDropzone.removeAllFiles()
      }, 

      getQueuedFiles() {
        return this.$refs.changePhotoDropzone.getQueuedFiles().length
      },
    }
  }
</script>

<style lang="scss" scoped>

</style>