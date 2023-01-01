<template>
  <input
    :type="type" @input="updateValue" :value="modelValue" :placeholder="props.placeholder"
    class="appearance-none outline-none bg-transparent border-b border-gray-400 w-full"
  >
</template>

<script setup>
let props = defineProps({
  modelValue: String,
  type: {
    type: String,
    default: 'text'
  },
  placeholder: {
    type: String,
    default: ''
  },
});

const emit = defineEmits(['update:modelValue']);

const updateValue = (event) => {
  emit('update:modelValue', event.target.value)
}
</script>

<style></style>
