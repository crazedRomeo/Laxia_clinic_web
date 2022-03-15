<template>
	<div class="rsv-status-select" v-if="selected && rsv_status_types" v-click-outside="closeDropdown">
		<h4 :class="selectedClass" @click="toggleDropdown">
			{{ selectedItem }}
			<!-- <svg width="12" height="8" viewBox="0 0 12 8" fill="none" xmlns="http://www.w3.org/2000/svg">
				<path d="M6.73176 7.10653C6.33249 7.57518 5.60863 7.57518 5.20936 7.10653L0.985327 2.14851C0.43218 1.49925 0.893587 0.5 1.74653 0.5L10.1946 0.500001C11.0475 0.500001 11.5089 1.49925 10.9558 2.14852L6.73176 7.10653Z"/>
			</svg> -->
		</h4>
		<!-- <ul class="dropdown__container" :class="{ dropped: dropFlag }">
			<li v-for="(item, key) in rsv_status_types" :key="key">
				<a @click="handleSelectStatus(key)">{{ item }}</a>
			</li>
		</ul> -->
	</div>
</template>
<script>
import { mapGetters } from 'vuex'

export default {
	name: "RsvStatusSelect",

	props: {
		selected: {
      type: String,
      default: "5"
		},
		rsvId: {
			type: Number,
		},
		change: {
			type: Function,
		}
	},

	components: {
	},

	data() {
		return {
			rsvStatuses: [],
			dropFlag: false,
		}
	},

	computed: {
		...mapGetters({
      rsv_status_types: 'constant/rsv_status_types',
		}),
		selectedItem() {
			if (this.selected <= 20) {
				return this.rsv_status_types[this.selected];
			} else {
				return '予約完了';
			}
		},
		selectedClass() {
			if (this.selected == 5) return 'not-supported';
			else if (this.selected == 10) return 'missed-call';
			else if (this.selected == 15) return 'in-progress';
			else if (this.selected >= 20) return 'approved';
		}
	},

	created() {
	},

	mounted() {
		// this.loadRsvStatuses()
	},

	methods: {
		toggleDropdown() {
			this.dropFlag = !this.dropFlag
		},
		closeDropdown() {
			this.dropFlag = false
		},
		handleSelectStatus(status) {
			this.dropFlag = false
			if (status != this.selected) {
				this.$emit('change', this.rsvId, status)
			}
		}
	},
}
</script>

<style lang="scss" scoped>
.rsv-status-select {
	width: 115px;
	position: relative;
	h4 {
		position: relative;
		height: 25px;
		// display: flex;
		justify-content: flex-start;
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