<script lang="ts">
    import ProductCard from '$lib/shared/cards/ProductCard.svelte';
	import { text } from 'svelte/internal';
    import { onMount } from 'svelte';
	import type { LabTest } from '$lib/interfaces.js';
    import labCartStore from '$lib/labCart.js';
	import LabCard from '$lib/shared/cards/LabCard.svelte';
	import DefaultButton from '$lib/shared/buttons/DefaultButton.svelte';
    
    export let data;
    let tests = (data.tests.data);
    let cartTests: LabTest[] = [];

    onMount(() => {
        labCartStore.subscribe((tests) => {
            cartTests = tests;
        });
    });

    
</script>

<div class="flex justify-center">
    <div class="w-full mt-10 ml-20">
        <div class="grid grid-cols-4 gap-6 mr-20">
            {#each tests as test}
                <a href="#top">
                    <LabCard name={test.name} price={test.price} link="/labtests/{test.name}?id={test.id}"/>
                </a>
            {/each}
        </div>
    </div>
</div>