import { mount } from '@vue/test-utils'
import { createMemoryHistory } from 'vue-router'
import App from './App.vue'
import { createAppRouter } from './router'

it('renders the KeyNest gallery title and redirects to overview', async () => {
  const router = createAppRouter(createMemoryHistory())

  await router.push('/')
  await router.isReady()

  const wrapper = mount(App, {
    global: {
      plugins: [router],
    },
  })

  expect(wrapper.text()).toContain('KeyNest 界面概览')
  expect(router.currentRoute.value.fullPath).toBe('/overview')
  expect(wrapper.text()).toContain('登录 KeyNest')
})
