<script lang="ts">
    import "../app.postcss";
    import "flowbite/dist/flowbite.css";
	import CartPage from "$lib/components/CartPage.svelte";
    import ExpandShadowButton from "$lib/shared/buttons/ExpandShadowButton.svelte";
    import TabButton from "$lib/shared/buttons/TabButton.svelte";
    import { base } from "$app/paths";
	import CartButton from "$lib/shared/buttons/CartButton.svelte";
    import cartStore from "$lib/cart";
    import jwtStore from "$lib/jwt";
    import { onMount } from "svelte";
    import type { CartItem } from "$lib/interfaces.js";
    
    let cart: CartItem[] = [];
    let jwt: string;
    onMount(() => {
        cartStore.subscribe((value) => {
            cart = value;
        });

        jwtStore.subscribe((value) => {
            jwt = value;
        });
    });

    let totalQty: number = 0;
    $: totalQty = cart.reduce((acc, item) => acc + item.quantity, 0);

    let sidebar_show: boolean;
    $: sidebar_show = false;

</script>

<header class=" text-gray-300 body-font bg-gray-800 shadow-xl ">
    <div
        class="container mx-auto flex flex-wrap p-5 flex-col md:flex-row items-center"
    >
        <a 
            class="flex title-font font-medium items-center text-gray-300 mb-4 md:mb-0"
            href="{base}/"
        >
            <img
                src="{base}/site-assets/logo-no-background.svg"
                alt="logo"
                width=200
                class=" text-white p-2"
            />
        </a>
        <nav
            class="m-auto flex flex-wrap items-center text-base justify-between"
        >
            <TabButton href="{base}/categories">Products</TabButton>
            <!-- <TabButton href="{base}/products">All products</TabButton>   -->
            <TabButton href="{base}/labtests">Lab Tests</TabButton>
        </nav>
            <div class="flex space-x-4 items-center">
                {#if jwt === null || jwt === ''}
                    <ExpandShadowButton style="border-radius: 0.5rem" invert={true} href="{base}/login">
                        Login</ExpandShadowButton
                    >
                    <ExpandShadowButton style="border-radius: 0.5rem" href="{base}/signup">
                        Signup</ExpandShadowButton
                    >
                {/if}
                
                
                <CartButton on:click={() => {sidebar_show = !sidebar_show}} qty={totalQty}/>
            </div>
    </div>
    <hr class="h-px bg-gray-700 border-gray-700 shadow-xl">
    
</header>

<slot></slot>   

<CartPage bind:show={sidebar_show}/>