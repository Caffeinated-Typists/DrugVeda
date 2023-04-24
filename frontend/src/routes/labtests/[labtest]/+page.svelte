<script lang="ts">
    import ProductButton from '$lib/shared/buttons/ProductButton.svelte';
    import { onMount } from "svelte";
    import type { LabTest } from "$lib/interfaces";
    import labCartStore from "$lib/labCart";
	import SuccessAlert from '$lib/shared/alerts/SuccessAlert.svelte';
	import { browser } from '$app/environment';
	import { A } from 'flowbite-svelte';

    let cartTests: LabTest[] = [];
    onMount(() => {
        labCartStore.subscribe((tests) => {
            cartTests = tests;
        });
    });
    export let data;
    let currentTest = data.test;
    let appointment = "";
    let display_alert = false;

    function addToCart() {
        console.log("called");
        // adding to test cart

        // check if item already in cart
        let item = cartTests.find((item) => item.id === currentTest.id);

        // update if item already in cart
        if (item) {
            item.quantity += 1;
            labCartStore.set(cartTests);
        } else {
            // add new item to cart
            let newItem: LabTest = {
                id: currentTest.id,
                name: currentTest.name,
                quantity: 1,
                price: currentTest.price,
                appointment: appointment
            };
            cartTests = [...cartTests, newItem];
            labCartStore.set(cartTests);
        }
    }

</script>


<!-- making the product page full screen -->
<style>
	.container {
		height: 100vh;
	}
</style>

<div class="text-gray-400 bg-gray-900 body-font flex flex-col relative w-full min-h-screen">
	<div class="container px-5 py-24 mx-auto bg-inherit">
		<div class="lg:w-4/5 mx-auto flex bg-inherit">
            <div class="lg:w-1/6 md:w-1/6 p-4 w-full ">
                <div class="relative h-96 ">
                    <div class="absolute inset-0 bg-white flex items-center justify-center ">
                        <img src="https://assets.pharmeasy.in/web-assets/dist/6b3d644c.svg" alt="{currentTest.name}" class="h-full w-48 object-contain align-middle " />
                    </div>
                </div>
            </div>
			<div class="lg:w-1/2 w-full lg:pl-10 lg:py-6 mt-6 lg:mt-0">
				<h2 class="text-sm title-font text-gray-500 tracking-widest">{currentTest.lab}</h2>
				<h1 class="text-white text-3xl title-font font-medium mb-1">{currentTest.name}</h1>

				<p class="leading-relaxed">
					{currentTest.desc}
				</p>
				<div class="flex mt-6 items-center pb-5 border-b-2 border-gray-800 mb-5">
					<div class="flex" />
				</div>
				<div class="flex justify-between">
					<span class="title-font font-medium text-2xl text-white">₹{currentTest.price}</span>
                    <a on:click={() => {addToCart()}} href="/checkout/lab">
                        <ProductButton name="Buy Now" color="teal"/>
                    </a>
				</div>

			</div>
            
		</div>
        {#if display_alert}
        <SuccessAlert >
            Success: Test added to cart
            </SuccessAlert>
    {/if}
	</div>
</div>

