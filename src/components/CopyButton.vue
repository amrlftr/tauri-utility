<template>
  <ut-button
    v-tippy="{ content: 'Copied!', trigger: 'click', onShown(instance) {
      setTimeoutHide(instance);
    }}"
    @click="copyToClipboard($event)"
    :is-disabled="props.isDisabled"
  >
    Copy
  </ut-button>
</template>

<script setup>
import UtButton from '@/components/form_elements/Button.vue';

const props = defineProps({
  text: {
    type: String,
    default: '',
  },
  isDisabled: {
    type: Boolean,
    default: false,
  }
});

const copyToClipboard = () => {
  navigator.clipboard.writeText(props.text);
}

const setTimeoutHide = (instance) => {
  setTimeout(() => {
    instance.hide();
  }, 1000);
}
</script>
<style>

</style>
