<template>
	<app-content title="Diagram">
		<template #leftOptions>
			<router-link to="/">
				<div class="flex items-center">
					<svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2 text-gray-800" viewBox="0 0 20 20" fill="currentColor">
						<path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" />
					</svg>
					<span class="text-xs uppercase font-bold text-gray-800" style="letter-spacing: 0.15em;">HOME</span>
				</div>
			</router-link>
		</template>
		<template #rightOptions>
      <router-link to="/">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-blue-500 bg-blue-200 p-2 rounded-full"
          viewBox="0 0 20 20" fill="currentColor">
          <path
            d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z" />
        </svg>
      </router-link>
    </template>


		<div class="p-4 mx-4 bg-white rounded-2xl space-y-4">
      <div>
        <h4 class="font-bold text-xl font-serif mb-2">
          Query
        </h4>
        <codemirror
          v-model="code"
          :extensions="[html(), oneDark]"
          :indent-with-tab="true"
          :tab-size="2"
        />
      </div>
      <div>
        <div ref="graph"></div>
			</div>
		</div>
	</app-content>
</template>

<script setup>
import { ref, watch } from 'vue';
import AppContent from '@/components/layouts/AppContent.vue';
import mermaid from 'mermaid/dist/mermaid.esm.min.mjs';
import { Codemirror } from 'vue-codemirror';
import { html } from "@codemirror/lang-html";
import { oneDark } from '@codemirror/theme-one-dark';
import { useDebounce } from '@/composables/debounce.js';

const { debounce } = useDebounce();

mermaid.initialize({ startOnLoad: false });

let code = ref('');
let graph = ref(null);

const buildDiagram = debounce(() => {
  mermaid.render('theGraph', code.value, function(svgCode) {
    graph.value.innerHTML = svgCode;
  });
}, 1000);

watch([code], () => {
  buildDiagram();
},{
  immediate:true
});
</script>
