<script lang="ts">
    import FilterPanel from '$lib/components/FilterPanel.svelte';
    import TopBar from '$lib/components/TopBar.svelte';
    import ProductCard from '$lib/shared/cards/ProductCard.svelte';

    export let data;

    let brands = data.product.brands;
    let subcats = data.product.products;

</script>

<!-- <p>{data}</p> -->

<div class="flex">

    <div style="display: flex; flex-direction: column; width: 60rem">
            <FilterPanel 
            brand_options={brands}
            slider_min={data.product.min_price}
            slider_max={data.product.max_price}
            />
        </div>
    
    
        <div >
            <TopBar />
            
            <div class="w-full mt-10">
                <div class="grid grid-cols-3 gap-6 mr-20">
                    {#each subcats as subcat}
                        {#each subcat.products as product}
                            <a href="#top">
                            <ProductCard name={product.name} price={product.price} image={`${product.image}`}/>
                            </a>
                        {/each}
                        
                    {/each}


                    <!-- <ProductCard />
                    <ProductCard />
                    <ProductCard />
                    <ProductCard />
                    
                    <ProductCard />
                    <ProductCard />
                    <ProductCard />
                    <ProductCard />
                    
                    <ProductCard />
                    <ProductCard />
                    <ProductCard />
                    <ProductCard /> -->
                </div>
            </div>
        </div>
    </div>