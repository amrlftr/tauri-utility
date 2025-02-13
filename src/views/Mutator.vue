<template>
  <app-content
    title="Duplication Mutator"
  >
    <template #sidebarContent>
      <accordion title="Text Case">
        <text-case class="shadow-sm" />
      </accordion>
      <accordion title="Template List">
        <div class="flex items-center justify-end mb-2">
          <ut-button @click="templateActionModal.show()">
            <template #icon>
              <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-white" viewBox="0 0 20 20"
                fill="currentColor">
                <path fill-rule="evenodd"
                  d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                  clip-rule="evenodd" />
              </svg>
            </template>
            New Template
          </ut-button>
        </div>
        <div class="space-y-2 p-4 bg-white rounded-xl shadow-sm">
          <div v-for="template in filteredTemplates" :key="`template-${template.id}`">
            <div class="font-bold text-gray-500 mb-1">{{ template.title }}</div>
            <div class="flex items-start justify-between">
              <div class="flex items-start">
                <input
                  @click="changeTemplate($event)"
                  name="radioButton" type="radio" :id="template.id" :value="template.code"
                  class="mt-1 appearance-none cursor-pointer checked:bg-yellow-500 ring-1 ring-gray-400 checked:ring-yellow-500 ring-offset-2 h-2 w-2 rounded-full"
                  :checked="code === template.code"
                >
                <label :for="template.id" class="ml-3 my-0 whitespace-pre-line leading-none">{{ template.code }}</label>
              </div>
              <svg @click="deleteTemplate(template.id)" xmlns="http://www.w3.org/2000/svg"
                class="h-4 w-4 rounded-full bg-red-100 p-0.5 text-red-500 cursor-pointer" viewBox="0 0 20 20"
                fill="currentColor">
                <path fill-rule="evenodd"
                  d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                  clip-rule="evenodd" />
              </svg>
            </div>
          </div>
        </div>
      </accordion>
    </template>
    <template #leftOptions>
      <router-link to="/">
        <div class="flex items-center">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2 text-gray-800" viewBox="0 0 20 20"
            fill="currentColor">
            <path fill-rule="evenodd"
              d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
              clip-rule="evenodd" />
          </svg>
          <span class="text-xs uppercase font-bold text-gray-800" style="letter-spacing: 0.15em;">HOME</span>
        </div>
      </router-link>
    </template>
    <template #rightOptions="{ triggerSidebar }">
      <router-link to="/">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-blue-500 bg-blue-200 p-2 rounded-full"
          viewBox="0 0 20 20" fill="currentColor">
          <path
            d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z" />
        </svg>
      </router-link>
      <Bars3Icon @click="triggerSidebar()" class="h-6 w-6 text-blue-500 cursor-pointer" aria-hidden="true" />
    </template>

    <div class="mb-5">
      <slider-select
        :datalist="[{
          id: 'single',
          desc: 'Single Mode'
        }, {
          id: 'multiple',
          desc: 'Multiple Mode'
        }]"
        v-model="selectedMode"
        @onChange="codeDefaultSwitcher()"
      />
    </div>

    <div
      :class="{ 'flex flex-col md:flex-row': selectedMode === 'single' }"
      class="max-w-full lg:max-w-5xl lg:mx-auto mx-6 py-2 px-6 bg-white rounded-2xl border-2 border-gray-200"
    >
      <div class="w-full p-4 space-y-4" style="min-width: 0;">
        <template v-if="selectedMode === 'single'">
          <div>
            <div class="flex items-center justify-between">
              <h4 class="font-bold text-xl font-serif">
                Data
              </h4>
              <paste-button @onPaste="dataSource = $event" />
            </div>
            <ut-textarea v-model="dataSource" :disabled="isSingleModeDistinct" />
            <h6 class="text-xs text-right pt-1">Separated by comma</h6>
          </div>
        </template>
        <template v-if="selectedMode === 'multiple'">
          <div>
            <div class="flex items-center justify-between">
              <h4 class="font-bold text-xl font-serif">
                Data
              </h4>
            </div>
            <div class="flex space-x-4 text-sm">
              <div>
                <div
                  v-for="(keywordMultiple, keywordMultipleCount) in keywordMultiples"
                  :key="`keyword-multiple-count-${keywordMultipleCount}`"
                  class="group p-2 border-b relative"
                >
                  <input type="text" class="w-full outline-none h-full" v-model="keywordMultiples[keywordMultipleCount]" />
                  <div class="absolute inset-y-0 right-0 flex items-center">
                    <XMarkIcon @click="delKeywordMultiple(keywordMultipleCount)" class="h-4 w-4 text-red-500 opacity-0 transition duration-300 group-hover:opacity-100 cursor-pointer" />
                  </div>
                </div>
                <ut-button @click="addKeywordMultiple()">
                  <template #icon>
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-white" viewBox="0 0 20 20"
                      fill="currentColor">
                      <path fill-rule="evenodd"
                        d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                        clip-rule="evenodd" />
                    </svg>
                  </template>
                  Add
                </ut-button>
              </div>
              <div class="flow-root grow">
                <ul role="list" class="-mb-4">
                  <li v-for="dataSourceMultipleCount in dataSourceMultiples.length" :key="`data-multiple-count-${dataSourceMultipleCount}`">
                    <div class="relative pb-4">
                      <span class="absolute top-5 left-5 -ml-px h-full w-0.5 bg-gray-200" aria-hidden="true" />
                      <div class="relative flex items-start space-x-3">
                        <div>
                          <div @click="delDataSourceMultiple(dataSourceMultipleCount-1)" class="relative cursor-pointer">
                            <div class="flex h-8 w-8 mx-1 items-center justify-center rounded-full bg-red-100 border border-red-200 ring-8 ring-white">
                              <TrashIcon class="text-red-500 h-4 w-4" />
                            </div>
                            <div class="absolute inset-0 mx-1 flex h-8 w-8 items-center justify-center rounded-full bg-gray-100 border border-gray-200 ring-8 ring-white opacity-100 transition duration-300 hover:opacity-0">
                              <span class="text-gray-500 font-bold p-4 " aria-hidden="true">{{ dataSourceMultipleCount }}</span>
                            </div>
                          </div>
                        </div>
                        <div class="w-full">
                          <div
                            class="flex items-center"
                            v-for="(item, itemCount) in dataSourceMultiples[dataSourceMultipleCount-1]"
                            :key="`data-multiple-count-inner-${itemCount}`"
                          >
                            <div class="bg-gray-100 p-2 rounded">
                              {{ keywordMultiples[itemCount] }}
                            </div>
                            <div class="p-2 grow border-b">
                              <input type="text" class="w-full outline-none h-full" v-model="dataSourceMultiples[dataSourceMultipleCount-1][itemCount]">
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </li>
                  <li>
                    <div class="relative pb-4">
                      <div class="relative flex items-start space-x-3">
                        <div>
                          <div @click="addDataSourceMultiple" class="relative px-1">
                            <div class="flex h-8 w-8 items-center justify-center rounded-full bg-green-100 border border-green-200 ring-8 ring-white cursor-pointer">
                              <PlusSmallIcon class="h-5 w-5 text-green-500" aria-hidden="true" />
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </template>

        <div>
          <div class="flex items-center justify-between mb-2">
            <h4 class="font-bold text-xl font-serif">
              Active Template
            </h4>
            <div v-show="selectedMode === 'single'" class="flex flex-row items-center">
              <span class="text-sm mr-2">Distinct</span>
              <toggle v-model="isSingleModeDistinct" />
            </div>
          </div>
          <template v-if="!isSingleModeDistinct">
            <codemirror
              v-model="code"
              :extensions="[html(), oneDark]"
              :indent-with-tab="true"
              :tab-size="2"
            />
            <h6 class="text-xs text-right pt-1">
              Modifiers are available in
              <span class="font-semibold text-blue-500">{{ '.' + Object.keys(textOperations).join(' .') }}</span>
            </h6>
          </template>
          <template v-else>
            <table class="min-w-full divide-y divide-gray-300 z-20">
              <tr v-for="(data, dataIndex) in dataSourceDistinct" :key="`dataSourceDistinct-${dataIndex}`">
                <td class="py-2 text-sm text-gray-500">{{ data.data }}</td>
                <td class="text-right py-2 pl-3 pr-4 text-sm text-gray-500 sm:pr-6 md:pr-0">
                  <Menu as="div" class="relative inline-block text-left">
                    <div>
                      <MenuButton
                        class="inline-flex w-full justify-center rounded-md bg-indigo-600 px-2 py-1 text-sm font-medium text-white hover:bg-indigo-700 focus:outline-none focus-visible:ring-2 focus-visible:ring-indigo-700 focus-visible:ring-opacity-75"
                      >
                        {{ data.operation.title || 'Template'}}
                        <ChevronDownIcon
                          class="ml-1 -mr-1 h-5 w-5 text-violet-200 hover:text-violet-100"
                          aria-hidden="true"
                        />
                      </MenuButton>
                    </div>

                    <transition
                      enter-active-class="transition duration-100 ease-out"
                      enter-from-class="transform scale-95 opacity-0"
                      enter-to-class="transform scale-100 opacity-100"
                      leave-active-class="transition duration-75 ease-in"
                      leave-from-class="transform scale-100 opacity-100"
                      leave-to-class="transform scale-95 opacity-0"
                    >
                      <MenuItems
                        class="absolute right-0 mt-2 w-56 origin-top-right divide-y divide-gray-100 rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none z-10"
                      >
                        <div class="px-1 py-1 max-h-56 overflow-y-scroll">
                          <div class="p-2">
                            <ut-input v-model="distinctFilterKeyword" placeholder="Filter" />
                          </div>
                          <MenuItem v-for="(template, templateIndex) in filteredTemplates" :key="`template-${dataIndex}-${templateIndex}-${template.id}`" v-slot="{ active }">
                            <button
                              @click="setDistinctOperation(dataIndex, template.id)"
                              :class="[
                                active ? 'bg-indigo-500 text-white' : 'text-gray-900',
                                'group flex w-full items-center rounded-md px-2 py-2 text-sm',
                              ]"
                            >
                              {{ template.title }}
                            </button>
                          </MenuItem>
                        </div>
                      </MenuItems>
                    </transition>
                  </Menu>
                </td>
              </tr>
            </table>
          </template>
        </div>

        <accordion v-show="selectedMode === 'single'" title="Options">
          <div class="space-y-4 bg-white rounded-xl p-4 shadow-sm">
            <div class="flex flex-row items-center justify-between">
              <span>Changer Keyword</span>
              <div class="grow-0">
                <ut-input v-model="keyword" />
              </div>
            </div>
            <div class="flex flex-row items-center justify-between">
              <span>Delimiter</span>
              <div class="grow-0">
                <ut-input v-model="delimiter" />
              </div>
            </div>
            <div class="flex flex-row items-center justify-between">
              <span>Newline</span>
              <toggle v-model="toggleNewline" />
            </div>
          </div>
        </accordion>
      </div>

      <div class="w-full p-4" style="min-width: 0;">
        <div class="flex items-center justify-between">
          <h4 class="font-bold text-xl font-serif">
            Result
          </h4>
          <copy-button :text="mutatedData" :is-disabled="mutatedData.length === 0" />
        </div>
        <div>
          <codemirror
            v-model="mutatedData"
            :disabled="true"
            :extensions="[html(), oneDark]"
            :indent-with-tab="true"
            :tab-size="2"
          />
        </div>
      </div>
    </div>

    <toast ref="toast"></toast>

    <modal
      ref="templateActionModal"
      title="Add New Template"
      action-label="Save"
      @action="addTemplate"
      cancel-label="Cancel"
      @cancel="templateActionModal.hide()"
    >
      <!-- <template #icon>
				<svg class="h-6 w-6 text-green-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
									stroke-width="2" stroke="currentColor" aria-hidden="true">
									<path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
								</svg>
			</template> -->
      <div class="mb-2">
        <ut-input
          v-model="newTemplate.title"
          placeholder="Title"
        />
      </div>
      <ut-textarea
        v-model="newTemplate.code"
        placeholder="Code"
      />
    </modal>

  </app-content>
</template>

<script setup>
import { ref, watch, onMounted, computed } from 'vue';
import CopyButton from '@/components/CopyButton.vue';
import PasteButton from '@/components/PasteButton.vue';
import Accordion from '@/components/Accordion.vue';
import Toggle from '@/components/form_elements/Toggle.vue';
import UtTextarea from '@/components/form_elements/Textarea.vue';
import UtInput from '@/components/form_elements/Input.vue';
import Modal from '@/components/Modal.vue';
import UtButton from '@/components/form_elements/Button.vue';
import SliderSelect from '@/components/form_elements/SliderSelect.vue';
import AppContent from '@/components/layouts/AppContent.vue';
import db from '@/datastore';
import { useDebounce } from '@/composables/debounce.js';
import { useTextCase } from '@/composables/text-case.js';
import { useHelpers } from '@/composables/helpers.js';
import { Bars3Icon, XMarkIcon, TrashIcon, PlusSmallIcon } from '@heroicons/vue/24/outline';
import { Codemirror } from 'vue-codemirror';
import { html } from "@codemirror/lang-html";
import { oneDark } from '@codemirror/theme-one-dark';
import Toast from '@/components/Toast.vue';
import TextCase from '@/components/modules/TextCase.vue';
import { Menu, MenuButton, MenuItems, MenuItem } from '@headlessui/vue';
import { ChevronDownIcon } from '@heroicons/vue/20/solid'

// Global
const { debounce } = useDebounce();
const { clearObject } = useHelpers();
const textOperations = useTextCase();
let selectedMode = ref('');
let code = ref(`console.log({x});`);

const changeTemplate = (el) => {
  code.value = el.target.value;
}

const codeDefaultSwitcher = () => {
  mutatedData.value = '';

  if(selectedMode.value === 'single'){
    code.value = 'console.log({x});';
    return;
  }

  code.value = 'console.log({x1});';
}

// Single Mode
let dataSource = ref('');
let mutatedData = ref('');

let keyword = ref('{x}');
let delimiter = ref(',');
let toggleNewline = ref(true);
let isSingleModeDistinct = ref(false);

const escapeRegExp = (string) => {
  return string.replace(/[-/\\^$*+?.()|[\]{}]/g, '\\$&'); //make sure that any special character is escaped
}

const triggerChangeData = debounce(() => {
  let newString = '';
  let newStringInner = '';
  let dataArr = dataSource.value.split(delimiter.value);

  // generate regex rule
  //let regex = new RegExp(escapeRegExp(keyword.value), "g"); //is the same as: var regex = /abc/g;
  let regex = new RegExp(`(${escapeRegExp(keyword.value)}.\s*(?:${Object.keys(textOperations).join('|')}))|(${escapeRegExp(keyword.value)})`, "g");
  let operationQueue = [];

  dataArr.forEach((data, index) => {
    newString += code.value.replace(regex, function (string) {
      operationQueue = string.split('.').slice(1);

      if(operationQueue.length){
        newStringInner = '';

        operationQueue.forEach(operation => {
          newStringInner += textOperations[operation](data.trim());
        });

        return newStringInner;
      }

      return data.trim();
    });

    newString += toggleNewline.value && ++index !== dataArr.length ? '\n' : '';
  })

  mutatedData.value = newString;
}, 1000);

watch([dataSource, keyword, delimiter, toggleNewline, code], () => {
  if(selectedMode.value !== 'single')
    return;

  triggerChangeData();
},{
  immediate:true,
});

// Single Mode - Distinct
let dataSourceDistinct = ref([]);
let distinctFilterKeyword = ref('');

const setDistinctOperation = (index, templateId) => {
  dataSourceDistinct.value[index].operation = Object.assign({}, filteredTemplates.value.find(template => template.id === templateId))
}

watch([isSingleModeDistinct], () => {
  if(isSingleModeDistinct.value === true){
    dataSourceDistinct.value = [];

    if(dataSource.value !== ''){
      dataSource.value.split(delimiter.value).forEach(data => {
        dataSourceDistinct.value.push({
          data,
          operation: {}
        })
      })
    }
  }

  distinctFilterKeyword.value = '';
},{
  immediate:true,
});

const triggerChangeDataDistinct = debounce(() => {
  let newString = '';
  let dataArr = dataSourceDistinct.value;

  // generate regex rule
  let regex = new RegExp(escapeRegExp(keyword.value), "g"); //is the same as: var regex = /abc/g;

  dataArr.forEach((data, index) => {
    if(!data.operation.id) {
      return;
    }

    newString += data.operation.code.replace(regex, data.data.trim()) + (toggleNewline.value && ++index !== dataArr.length ? '\n' : '');
  })

  mutatedData.value = newString;
}, 1000);

watch([dataSourceDistinct], () => {
  triggerChangeDataDistinct();
},{
  deep: true,
});

// Multiple Mode
let dataSourceMultiples = ref([
  ['']
]);
let keywordMultiples = ref(['{x1}']);

const addDataSourceMultiple = () => {
  dataSourceMultiples.value.push(
    Array.apply(null, Array(
      keywordMultiples.value.length
    )).map(function () { return '' })
  );
}

const delDataSourceMultiple = (index) => {
  dataSourceMultiples.value.splice(index, 1);
}

const addKeywordMultiple = () => {
  keywordMultiples.value.push(`{x${keywordMultiples.value.length+1}}`);
  dataSourceMultiples.value.forEach((data) => {
    data.push('');
  })
}

const delKeywordMultiple = (index) => {
  keywordMultiples.value.splice(index, 1);
  dataSourceMultiples.value.forEach((data) => {
    data.splice(index, 1);
  })
}

const triggerChangeDataMultiples = debounce(() => {
  let newString = '';
  let newStringInner = '';
  let codeCopy = '';
  let regex = null;
  let operationQueue = [];

  for (let i = 0; i < dataSourceMultiples.value.length; i++) {
    codeCopy = code.value;
    for (let j = 0; j < dataSourceMultiples.value[i].length; j++) {
      //ignore if keyword is empty string
      if(keywordMultiples.value[j] === '')
        continue;

      // regex = new RegExp(escapeRegExp(keywordMultiples.value[j]), "g"); //is the same as: var regex = /abc/g;
      regex = new RegExp(`(${escapeRegExp(keywordMultiples.value[j])}.\s*(?:${Object.keys(textOperations).join('|')}))|(${escapeRegExp(keywordMultiples.value[j])})`, "g");
      operationQueue = [];

      codeCopy = codeCopy.replace(regex, function (string) {
        operationQueue = string.split('.').slice(1);

        if(operationQueue.length){
          newStringInner = '';

          operationQueue.forEach(operation => {
            newStringInner += textOperations[operation](dataSourceMultiples.value[i][j].trim());
          });

          return newStringInner;
        }

        return dataSourceMultiples.value[i][j].trim();
      });
    }

    newString += codeCopy + (i+1 !== dataSourceMultiples.value.length ? '\n' : '');
    mutatedData.value = newString;
  }
}, 1000);

watch([keywordMultiples, dataSourceMultiples, code], () => {
  if(selectedMode.value !== 'multiple')
    return;

  triggerChangeDataMultiples();
},{
  deep: true
});

// Template CRUD
let templates = ref([]);
let newTemplate = ref({
  title: '',
  code: ''
});
const templateActionModal = ref(null);
const toast = ref(null);

const fetchTemplate = async () => {
  try {
    templates.value = [];

    let rows = await db.select(`SELECT * FROM mutator_templates`);

    rows.forEach((row) => {
      templates.value.push({
        id: row.id,
        title: row.title,
        code: row.code,
        type: row.type
      });
    })
  } catch (err) {
    toast.value.show({
      type: 'danger',
      message: err,
    });
  }
}

const addTemplate = async () => {
  try {
    await db.execute("INSERT INTO mutator_templates (title, code, type, is_default) VALUES (?1, ?2, ?3, ?4)", [newTemplate.value.title, newTemplate.value.code, selectedMode.value, 0]);

    await fetchTemplate();
    templateActionModal.value.hide();
    clearObject(newTemplate.value);

    toast.value.flash({
      type: 'success',
      title: 'Data inserted successfully',
    });
  } catch (err) {
    toast.value.show({
      type: 'danger',
      message: err,
    });
  }
}

const deleteTemplate = async (id) => {
  try {
    await db.execute("DELETE FROM mutator_templates WHERE id = ?1", [id]);
    await fetchTemplate();

    toast.value.flash({
      type: 'success',
      title: 'Data deleted successfully',
    });
  } catch (err) {
    toast.value.show({
      type: 'danger',
      message: err,
    });
  }
}

const filteredTemplates = computed(() => {
  let templatesCopy = [];

  templatesCopy = templates.value.filter((template) => template.type === selectedMode.value);

  if(distinctFilterKeyword.value !== '')
    templatesCopy = templatesCopy.filter((template) => template.title.toLowerCase().includes(distinctFilterKeyword.value));

  return templatesCopy;
});

onMounted(() => {
  fetchTemplate();
});
</script>
