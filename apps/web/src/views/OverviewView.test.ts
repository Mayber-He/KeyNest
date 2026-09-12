import { mount } from '@vue/test-utils'
import OverviewView from './OverviewView.vue'

it('switches the preview without putting gallery copy inside the product frame', async () => {
  const wrapper = mount(OverviewView)

  await wrapper.get('[data-page="vault"]').trigger('click')

  expect(wrapper.get('[data-product-frame]').text()).toContain('密码库')
  expect(wrapper.get('[data-product-frame]').text()).not.toContain('界面概览')
})

it('keeps implementation helper copy outside the product frame', () => {
  const wrapper = mount(OverviewView)

  expect(wrapper.get('[data-product-frame]').text()).not.toContain('下一阶段')
})

it('shows a product action after the new-item dialog is cancelled', async () => {
  const wrapper = mount(OverviewView)

  await wrapper.get('[data-page="new-item"]').trigger('click')
  const cancel = wrapper.findAll('button').find((button) => button.text() === '取消')
  await cancel!.trigger('click')

  expect(wrapper.find('[role="dialog"]').exists()).toBe(false)
  expect(wrapper.get('[data-product-frame]').text()).toContain('新建项目')
})
