import { mount } from '@vue/test-utils'
import App from './App.vue'

it('renders the KeyNest gallery title', () => {
  expect(mount(App).text()).toContain('KeyNest 界面概览')
})
