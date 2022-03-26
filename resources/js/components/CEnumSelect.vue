<template>
  <div class="custom-select" :tabindex="tabindex" @blur="open = false">
    <div class="selected" :class="{ open: open }" @click="open = !open">
      {{ selected == null? '': options[selected] }}
    </div>
    <div class="items" :class="{ selectHide: !open }">
      <div
        v-if="emptyable"
        @click="
          selected = null;
          open = false;
          $emit('change', null);
        "
        class="empty-item"
        ></div>
      <div
        v-for="(name, id) in options"
        :key="id"
        @click="
          selected = parseInt(id);
          open = false;
          $emit('change', parseInt(id));
        "
      >
        {{ name }}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    options: {
      type: Object,
      required: true,
    },
    default: {
      type: Number,
      required: false,
      default: null,
    },
    tabindex: {
      type: Number,
      required: false,
      default: 0,
    },
    emptyable: {
      type: Boolean,
      required: false,
      default: true,
    }
  },
  data() {
    return {
      selected: this.default
        ? this.default
        : null,
      open: false,
    };
  },
  mounted() {
    this.$emit("change", this.selected);
  },
  methods: {
    clear() {
      if(this.emptyable) this.selected = null;
    },
    set(selected) {
        this.selected = selected;
    }
  },
};
</script>

<style scoped>
.custom-select {
  position: relative;
  width: 100%;
  min-height: 40px;
  padding: 0;
  border: none;
  border-radius: 5px;
  background:url(/img/polygon.svg) no-repeat right #fff;
  background-position: calc(100% - 10px) 1em, calc(100% - 16px) calc(1em + 2px), 100% 0;
}
.custom-select:focus,.custom-select:focus-within{
    box-shadow: none;
}
.custom-select .selected:hover{
    border: 1px solid #8C9FAB;
}

.custom-select .selected {
  background-color: transparent;
  border-radius: 6px;
  color: #131340;
  cursor: pointer;
  border: 1px solid #C9D6DF;
  user-select: none;
  padding: 3px 8px;
  min-height: 40px;
  line-height: 28px;
}

.custom-select .selected.open {
  border: 1px solid #5CA3F6;
  border-radius: 5px;
  box-shadow: none;
}

.custom-select .items {
  color: #131340;
  font-size: 16px;
  overflow: hidden;
  position: absolute;
  background-color: white;
  left: 0;
  right: 0;
  z-index: 1;
  box-shadow: 0 1px 6px rgb(0 0 0 / 15%);
}

.custom-select .items div {
  color: #131340;
  padding: 5px 0px 5px 8px;
  cursor: pointer;
  user-select: none;
}

.custom-select .items div.empty-item {
  min-height: 35px;
}

.custom-select .items div:hover {
  background-color: #F2F5F9;
}

.selectHide {
  display: none;
}
</style>
