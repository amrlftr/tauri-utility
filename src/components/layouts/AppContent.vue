<template>
  <div class="bg-gray-100 min-h-screen py-5 text-gray-800 px-6 sm:px-0">
    <div class="max-w-2xl lg:max-w-5xl mx-auto flex items-center justify-evenly mb-5">
      <div>
        <slot name="leftOptions"></slot>
      </div>
      <div class="hidden sm:flex w-full bg-gray-300 h-px dark:bg-gray-700 mx-4"></div>
      <h1 class="text-3xl font-bold font-serif">
        <span class="highlight px-2 whitespace-nowrap">{{ title }}</span>
      </h1>
      <div class="hidden sm:flex w-full bg-gray-300 h-px dark:bg-gray-700 mx-4"></div>
      <div class="flex items-center space-x-2">
        <slot name="rightOptions" :triggerSidebar="triggerSidebar"></slot>
      </div>
    </div>

    <slot></slot>

    <TransitionRoot v-if="slots.sidebarContent" as="template" :show="isSidebarOpen">
      <Dialog as="div" class="relative z-10" @close="isSidebarOpen = false">
        <div class="fixed inset-0" />

        <div class="fixed inset-0 overflow-hidden">
          <div class="absolute inset-0 overflow-hidden">
            <div class="pointer-events-none fixed inset-y-0 right-0 flex max-w-full pl-10 sm:pl-16">
              <TransitionChild as="template" enter="transform transition ease-in-out duration-500 sm:duration-700" enter-from="translate-x-full" enter-to="translate-x-0" leave="transform transition ease-in-out duration-500 sm:duration-700" leave-from="translate-x-0" leave-to="translate-x-full">
                <DialogPanel class="pointer-events-auto w-screen max-w-2xl">
                  <div class="flex h-full flex-col overflow-y-scroll bg-white py-6 shadow-xl">
                    <div class="px-4 sm:px-6">
                      <div class="flex items-start justify-between">
                        <DialogTitle class="text-lg font-medium text-gray-900">Sidebar</DialogTitle>
                        <div class="ml-3 flex h-7 items-center">
                          <button type="button" class="rounded-md bg-white text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2" @click="isSidebarOpen = false">
                            <span class="sr-only">Close panel</span>
                            <XMarkIcon class="h-6 w-6" aria-hidden="true" />
                          </button>
                        </div>
                      </div>
                    </div>
                    <div class="relative mt-6 flex-1 px-4 sm:px-6">
                      <slot name="sidebarContent"></slot>
                    </div>
                  </div>
                </DialogPanel>
              </TransitionChild>
            </div>
          </div>
        </div>
      </Dialog>
    </TransitionRoot>
  </div>
</template>

<script setup>
import { ref, useSlots } from 'vue';
import { Dialog, DialogPanel, DialogTitle, TransitionChild, TransitionRoot } from '@headlessui/vue';
import { XMarkIcon } from '@heroicons/vue/24/outline';

defineProps({
  title: {
    type: String,
    default: 'Title'
  },
  sidebarOptions: {
    type: Object,
    default: {}
  }
});

const slots = useSlots();

const isSidebarOpen = ref(true);

const triggerSidebar = () => {
  isSidebarOpen.value = !isSidebarOpen.value;
}
</script>

<style>
.highlight {
  background: linear-gradient(180deg, rgba(255, 255, 255, 0) 60%, #BFDBFE 30%);
}
</style>
