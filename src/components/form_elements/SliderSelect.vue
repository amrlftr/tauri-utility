<template>
  <div class="flex items-center justify-center space-x-4">
    <ChevronLeftIcon @click="selectPrev(modelValue)" class="h-3 w-3 text-gray-500 cursor-pointer hover:scale-150 transition duration-500" />
    <div class="text-xs uppercase font-bold text-gray-500" style="letter-spacing: 0.15em;">{{ modelValue }}</div>
    <ChevronRightIcon @click="selectNext" class="h-3 w-3 text-gray-500 cursor-pointer hover:scale-150 transition duration-500" />
  </div>
</template>

<script setup>
import { onMounted } from 'vue';
import { ChevronLeftIcon, ChevronRightIcon } from '@heroicons/vue/24/outline';

const props = defineProps({
  datalist: Array,
  modelValue: String
});

const emit = defineEmits(['update:modelValue', 'onChange']);

onMounted(() => {
  if(!props.datalist.includes(props.modelValue))
    emit('update:modelValue', props.datalist[0]);
});

const selectPrev = () => {
  const currIndex = props.datalist.findIndex((data) => data === props.modelValue);

  currIndex === 0
    ? emit('update:modelValue', props.datalist[props.datalist.length-1])
    : emit('update:modelValue', props.datalist[currIndex-1]);

    emit('onChange');
}

const selectNext = () => {
  const currIndex = props.datalist.findIndex((data) => data === props.modelValue);

  currIndex+1 === props.datalist.length
  ? emit('update:modelValue', props.datalist[0])
  : emit('update:modelValue', props.datalist[currIndex+1]);

  emit('onChange');
}
</script>

<style>

</style>
