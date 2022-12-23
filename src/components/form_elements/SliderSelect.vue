<template>
  <div class="flex items-center justify-center space-x-4">
    <ChevronLeftIcon @click="selectPrev()" class="h-3 w-3 text-gray-500 cursor-pointer hover:scale-150 transition duration-500" />
    <div class="text-xs uppercase font-bold text-gray-500" style="letter-spacing: 0.15em;">{{ currModel }}</div>
    <ChevronRightIcon @click="selectNext" class="h-3 w-3 text-gray-500 cursor-pointer hover:scale-150 transition duration-500" />
  </div>
</template>

<script setup>
import { onMounted, computed } from 'vue';
import { ChevronLeftIcon, ChevronRightIcon } from '@heroicons/vue/24/outline';

const props = defineProps({
  datalist: Array,
  modelValue: String
});

const emit = defineEmits(['update:modelValue', 'onChange']);

onMounted(() => {
  if(!props.datalist.find((data) => data.id === props.modelValue))
    emit('update:modelValue', props.datalist[0].id);
});

const currModel = computed({
  get() {
    return props.datalist.find((data) => data.id === props.modelValue)?.desc;
  },
  set(newValue) {
    emit('update:modelValue', newValue.id);
  }
})

const selectPrev = () => {
  const currIndex = props.datalist.findIndex((data) => data.id === props.modelValue);

  currIndex === 0
    ? emit('update:modelValue', props.datalist[props.datalist.length-1].id)
    : emit('update:modelValue', props.datalist[currIndex-1].id);

    emit('onChange');
}

const selectNext = () => {
  const currIndex = props.datalist.findIndex((data) => data.id === props.modelValue);

  currIndex+1 === props.datalist.length
  ? emit('update:modelValue', props.datalist[0].id)
  : emit('update:modelValue', props.datalist[currIndex+1].id);

  emit('onChange');
}
</script>

<style>

</style>
