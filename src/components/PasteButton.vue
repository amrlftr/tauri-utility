<template>
  <ut-button
    v-tippy="{ content: 'Pasted!', trigger: 'click', onShown(instance) {
      setTimeoutHide(instance);
    }}"
    @click="paste()"
    :is-disabled="isDisabled"
  >
    Paste
  </ut-button>
</template>

<script setup>
import UtButton from '@/components/form_elements/Button.vue';

const props = defineProps({
  isDisabled: {
    type: Boolean,
    default: false,
  }
});

const emit = defineEmits(['onPaste']);

const paste = () => {
  navigator.clipboard.readText()
    .then((text) => {
      emit('onPaste', text);
    })
}

const setTimeoutHide = (instance) => {
  setTimeout(() => {
    instance.hide();
  }, 1000);
}
</script>
<style>

</style>
