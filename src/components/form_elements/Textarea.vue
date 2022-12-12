<template>
  <div class="relative">
    <textarea
      rows="4" @input="updateValue" :value="modelValue"
      class="appearance-none outline-none bg-transparent border border-gray-400 w-full px-4 py-2"
    ></textarea>
    <div class="absolute -top-1 inset-x-0 bg-white h-2 mx-3"></div>
    <div class="absolute bottom-1 inset-x-0 bg-white h-2 mx-3"></div>
  </div>
</template>

<script setup>
defineProps({
  modelValue: String
});

const emit = defineEmits(['update:modelValue']);

const updateValue = (event) => {
  emit('update:modelValue', event.target.value)
}
</script>

<style></style>
