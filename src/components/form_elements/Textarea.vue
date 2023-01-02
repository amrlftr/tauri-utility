<template>
  <div class="relative">
    <textarea
      rows="4" @input="updateValue" :value="modelValue"
      class="appearance-none outline-none border border-gray-400 w-full px-4 py-2"
      :class="[ props.disabled ? 'bg-gray-100 text-gray-500' : 'bg-transparent' ]"
      :placeholder="props.placeholder" :disabled="props.disabled"
    ></textarea>
    <div class="absolute -top-1.5 inset-x-0 bg-white h-2 mx-3"></div>
    <div class="absolute bottom-0 inset-x-0 bg-white h-2 mx-3"></div>
  </div>
</template>

<script setup>
let props = defineProps({
  modelValue: String,
  placeholder: {
    type: String,
    default: ''
  },
  disabled: {
    type: Boolean,
    default: false
  },
});

const emit = defineEmits(['update:modelValue']);

const updateValue = (event) => {
  emit('update:modelValue', event.target.value)
}
</script>

<style></style>
