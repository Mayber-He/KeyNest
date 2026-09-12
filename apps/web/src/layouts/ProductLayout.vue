<template>
  <div class="product-layout">
    <div class="product-layout__sidebar"><slot name="sidebar" /></div>
    <div class="product-layout__list"><slot name="list" /></div>
    <main class="product-layout__main"><slot /></main>
  </div>
</template>

<style scoped>
.product-layout {
  display: grid;
  width: 100%;
  min-height: 680px;
  grid-template-columns: 220px 310px minmax(0, 1fr);
  background: var(--color-surface);
}

.product-layout__sidebar,
.product-layout__list,
.product-layout__main {
  min-width: 0;
}

@container product-frame (max-width: 1099px) {
  .product-layout {
    grid-template-columns: 220px minmax(0, 1fr);
  }

  .product-layout__list {
    display: none;
  }
}

@container product-frame (max-width: 719px) {
  .product-layout {
    display: block;
  }

  .product-layout__sidebar,
  .product-layout__list {
    display: none;
  }
}
</style>
