import { mount } from '@vue/test-utils'
import GeneratorView from './GeneratorView.vue'

it('shows short-lived feedback after copying the generated result', async () => {
  const wrapper = mount(GeneratorView)

  await wrapper.get('button[aria-label="复制生成结果"]').trigger('click')

  expect(wrapper.get('.generator-view__toast[role="status"]').text()).toBe('已复制')
})
