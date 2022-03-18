<template>
	<div class="form-modal-wrapper" :class="{ 'is-open': isShow }">
		<div class="form-modal-mask" @click="hide"></div>
		<div class="form-modal-content">
			<div class="form-modal-header">
				<div class="form-modal-title">{{ title }}</div>
				<span class="form-modal-close-btn" @click="hide">
					<!-- <img src="/img/img-modal-close.png" /> -->
					<svg width="22" height="22" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path d="M20.5 1.5L1.5 20.5" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M1.5 1.5L20.5 20.5" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
					</svg>
				</span>
			</div>
			<div class="form-modal-body">
				<slot></slot>
			</div>
			<div v-if="$slots.footer" class="form-modal-footer">
				<slot name="footer"></slot>
			</div>
		</div>
	</div>
</template>

<script>
export default {
	name: "FormModal",

	props: {
    title: {
      type: String,
      default: "確認"
    },
	},

	data: () => ({
		isShow: false,
		payload: undefined,
	}),

	mounted() {
	},

	methods: {
		show(payload = null) {
			$('.form-modal-body').scrollTop(0);
			this.payload = payload
			this.isShow = true
		},

		hide() {
			this.payload = undefined
			this.isShow = false
			this.$emit('cancel')
		},

		confirm() {
			this.$emit('confirm', this.payload)
		}
	}
}
</script>

<style lang="scss" scoped>
.form-modal-wrapper {
	transition-duration: .2s;
	z-index: 1000;
	position: absolute;
	left: calc(50% - 425px);
	// height: 100vh;
	display: flex;
	justify-content: center;
	align-items: flex-start;
	opacity: 0;
	pointer-events: none;

	&.is-open {
		opacity: 1;
		pointer-events: all;
		.form-modal-content {
			transform: none;
		}
	}
	.form-modal-mask {
		position: fixed;
		top: 0;
		left: 0;
		width: 100vw;
		height: 100vh;
		background-color: rgba(0, 0, 0, .5);
		z-index: 9;
	}
	.form-modal-content {
		position: relative;
		background-color: #fff;
		width: 850px;
		height: unset;
		z-index: 10;
		background-color: #fff;
		border-radius: 20px;
		overflow: hidden;
		transform: translateY(20px);
		transition: .4s;
		box-shadow: 0 5px 15px rgba(0, 0, 0, .5);

		.form-modal-header {
			position: relative;
			padding: 9px 0;
			text-align: center;
			background: #5CA3F6;
			border-bottom: 1px solid #e5e5e5;

			.form-modal-title {
				font-size: 24px;
    			color: #fff;
				font-weight: bold;
				letter-spacing: 0.1em;
				h5 {
					font-weight: bold;
				}
				.close {
					position: absolute;
					top: 18px;
					right: 25px;
					color: #fff;
					opacity: 1;
					margin-top: -2px;
					outline: none;
				}
			}
			.form-modal-close-btn {
				position: absolute;
				top: calc(50% - 13px);
				right: 30px;
				cursor: pointer;
			}
		}
		.form-modal-body {
			width: 100%;
			margin-left: auto;
			margin-right: auto;
		}
		.form-modal-footer {
			text-align: center;
			border-top: 1px solid #dee2e6;

			.form-modal-actions {
				display: flex;
				align-items: center;
				justify-content: space-between;
			}
		}
	}
}
</style>
