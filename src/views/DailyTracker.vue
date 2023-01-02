<template>
	<app-content title="Daily Tracker">
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
				<svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-blue-500 bg-blue-200 p-2 rounded-full" viewBox="0 0 20 20" fill="currentColor">
					<path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z" />
				</svg>
			</router-link>
		</template>

		<div class="max-w-full lg:max-w-5xl flex flex-col p-4 mx-6 bg-white rounded-2xl border-2 border-gray-200">
      <div class="grid grid-cols-1 gap-5 sm:grid-cols-2">
        <div v-for="(activity, index) in activities" :key="index">
          <!-- <h3 class="font-display text-3xl font-bold tracking-tight text-slate-900">Optimizing for production</h3> -->
          <ol role="list" class="divide-y divide-slate-300/30 rounded-2xl bg-slate-50 py-3 px-6 text-base tracking-tight sm:py-7 sm:px-8">
            <li >
              <div class="flex justify-between py-3">
                <span class="font-medium text-slate-900">{{ activity.goal }}</span>
                <span class="text-slate-400">{{ activity.habits.filter(habit => habit.is_done === true).length + '/' + activity.habits.length }}</span>
              </div>
              <div class="relative flex pb-4 sm:mx-0 sm:block overflow-visible sm:pb-0">
                <div class="absolute bottom-0 top-2 left-0.5 w-px bg-slate-200 lg:block"></div>
                <div class="grid auto-cols-auto justify-start gap-y-3 whitespace-nowrap sm:mx-auto sm:max-w-2xl grid-flow-row lg:grid-cols-1">
                  <div v-for="(habit, habitIndex) in activity.habits" :key="`${index}-${habitIndex}`" class="relative pl-4">
                    <svg
                      viewBox="0 0 6 6"
                      class="absolute top-[0.5625rem] left-[-0.5px] h-1.5 w-1.5 overflow-visible cursor-pointer"
                      :class="[ activities[index].habits[habitIndex].is_done ? 'fill-blue-600 stroke-blue-600' : 'fill-transparent stroke-slate-400']"
                      @click="setDone(index, habitIndex)"
                    >
                      <path d="M3 0L6 3L3 6L0 3Z" stroke-width="2" stroke-linejoin="round"></path>
                    </svg>
                    <div class="relative">
                      <div class="text-sm">
                        <span class="absolute inset-0"></span>{{ habit.name }}
                        <div class="">
                          <span v-if="habit.cue" class="font-bold text-indigo-400 mr-2">Cue</span> {{ habit.cue }}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </li>
          </ol>
        </div>
      </div>
		</div>
	</app-content>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import AppContent from '@/components/layouts/AppContent.vue';
import dayjs from "dayjs";

let activities = ref([]);

onMounted(() => {
  if(localStorage.getItem("daily_tracker") === null){
    initTracker();
  }

  let data = JSON.parse(localStorage.getItem("daily_tracker"));
  let isToday = dayjs(data.date).isSame(dayjs(), 'day');
  // let isYesterday = dayjs(someDate).isSame(dayjs().subtract(1, 'day'));

  if(!isToday){
    initTracker();
    data = JSON.parse(localStorage.getItem("daily_tracker"));
  }

  activities.value = data.activities;
});

const initTracker = () => {
  localStorage.removeItem("daily_tracker");
  localStorage.setItem("daily_tracker", JSON.stringify({
    date: dayjs(),
    // date: dayjs("01-02-2023", "DD-MM-YYYY"),
    activities: [
      {
        goal: 'AI Necromancer',
        habits: [
          {
            name: 'Fill daily achievements',
            cue: 'Before sleeping',
            is_done: false,
          },
          {
            name: 'Add one entry to notion',
            cue: '',
            is_done: false,
          }
        ],
      },
      {
        goal: 'Reader Citizen',
        habits: [
          {
            name: 'Read 5 page',
            cue: 'Before sleeping',
            is_done: false,
          },
        ],
      },
      {
        goal: 'Fit physical',
        habits: [
          {
            name: '5 minutes walk',
            cue: 'After isya\'',
            is_done: false,
          },
        ],
      }
    ]
  }));
}

const setDone = (activityIndex, habitIndex) => {
  activities.value[activityIndex].habits[habitIndex].is_done = !activities.value[activityIndex].habits[habitIndex].is_done;

  localStorage.setItem("daily_tracker", JSON.stringify({
    date: new Date(),
    activities: activities.value
  }));
}

</script>
