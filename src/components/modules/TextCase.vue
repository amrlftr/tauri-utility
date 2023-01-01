<template>
  <div class="bg-white rounded-xl">
    <div class="w-full p-4 space-y-4">
      <div class="flex items-center justify-between">
        <h4 class="font-bold text-xl font-serif">
          Data
        </h4>
        <paste-button @onPaste="originalData = $event" />
      </div>

      <ut-textarea v-model="originalData" />

      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 bg-gray-100 rounded-lg">
        <div v-for="(type, index) in   ['capitalize', 'titlecase', 'lowercase', 'reset']" :key="index"
          @click="type !== 'reset' ? caseType = type : caseType = ''"
          :class="[caseType === type ? 'bg-indigo-600 text-white font-semibold' : 'text-gray-800']"
          class="px-2 py-1 text-center rounded-lg cursor-pointer font-medium capitalize">
          {{ type }}
        </div>
      </div>
    </div>

    <div class="w-full p-4 space-y-4">
      <div class="flex items-center justify-between">
        <h4 class="font-bold text-xl font-serif">
          Result
        </h4>
        <copy-button :text="mutatedData" :is-disabled="mutatedData.length === 0" />
      </div>
      <ut-textarea v-model="mutatedData" />
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue';
import { useDebounce } from '@/composables/debounce.js';
import UtTextarea from '@/components/form_elements/Textarea.vue';
import CopyButton from '@/components/CopyButton.vue';
import PasteButton from '@/components/PasteButton.vue';

// Text Operations
let originalData = ref('');
let mutatedData = ref('');
let caseType = ref('capitalize');

let delimiter = ref(' ');
let excludes = ref('');
let separator = ref(' ');
let toggleNewline = ref(false);

const { debounce } = useDebounce();

const textOperations = {
  capitalize: (string) => {
    return string.toUpperCase();
  },
  lowercase: (string) => {
    return string.toLowerCase();
  },
  titlecase: (string) => {
    return string.charAt(0).toUpperCase() + string.toLowerCase().slice(1);
  },
};

const triggerChangeData = debounce(() => {
  let newString = '';
  let dataArr = originalData.value.split(delimiter.value);

  dataArr.forEach((string, index) => {
    newString += (excludes.value.split(',').includes(string)
      ? string
      : caseType.value !== ''
        ? textOperations[caseType.value](string)
        : string
    ).trim() + (toggleNewline.value ? '\n' : dataArr.length !== index + 1 ? separator.value : '');
  });

  mutatedData.value = newString;
}, 1000);

watch([originalData, caseType], () => {
  triggerChangeData();
});
</script>
