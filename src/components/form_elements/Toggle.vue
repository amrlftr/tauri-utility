<template>
  <button
    type="button"
    @click="$emit('update:modelValue', !modelValue)"
    class="flex-shrink-0 group relative rounded-full inline-flex items-center justify-center h-5 w-10 cursor-pointer focus:outline-none focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:ring-indigo-600 focus-visible:ring-opacity-75"
    role="switch" aria-checked="false"
  >
    <span aria-hidden="true" class="pointer-events-none absolute bg-white w-full h-full rounded-md"></span>
    <span aria-hidden="true" :class="[ modelValue ? 'bg-indigo-600' : 'bg-gray-200' ]"
      class="pointer-events-none absolute h-4 w-9 mx-auto rounded-full transition-colors ease-in-out duration-200"></span>
    <span aria-hidden="true" :class="[ modelValue ? 'translate-x-5' : 'translate-x-0' ]"
      class="pointer-events-none absolute left-0 inline-block h-5 w-5 border border-gray-200 rounded-full bg-white shadow transform ring-0 transition-transform ease-in-out duration-200"></span>
  </button>
</template>

<script setup>
  defineProps(['modelValue'])
  defineEmits(['update:modelValue'])
</script>

<!-- <script>
export default {
  props: ['value'],
}
</script> -->
<style></style>
