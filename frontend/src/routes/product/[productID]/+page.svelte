<script lang="ts">
    import ProductButton from '$lib/shared/buttons/ProductButton.svelte';
    import StarRating from '@ernane/svelte-star-rating';
	import { onMount } from 'svelte';
    import cartStore from '$lib/cart';
	import type { CartItem } from '$lib/interfaces.js';


    export let data;
    let product = data.product.data;

	let cart: CartItem[] = [];
	onMount(() => {
		cartStore.subscribe((value) => {
			cart = value;
		});
	});

	function addToCart() {
		console.log("Adding to cart")
		// check if item already in cart
		let item = cart.find((item) => item.pid === data.product.data.id);

		// update if item already in cart
		if (item) {
			item.quantity += 1;
			cartStore.set(cart);
		} else {
			// add new item to cart

			let newItem: CartItem = {
				pid: data.product.data.id,
				name: data.product.data.name,
				quantity: 1,
				price: data.product.data.price,
				image: data.product.data.image
			};
			cartStore.update((cart) => [
				...cart,
				newItem
			]);
		}

		console.log(cart);
	}


	const config = {
		readOnly: true,
		countStars: 5,
		range: {
			min: 0,
			max: 5,
			step: 1
		},
        score: product.rating,
		showScore: false,
		starConfig: {
			size: 25,
			fillColor: '#5eead4',
			strokeColor: '#5eead4',
			unfilledColor: '#FFFFFF',
			strokeUnfilledColor: '#000000'
		}
	};

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
                        <img src={product.image} alt="{product.name}" class="h-full w-48 object-contain align-middle " />
                    </div>
                </div>
            </div>
			<div class="lg:w-1/2 w-full lg:pl-10 lg:py-6 mt-6 lg:mt-0">
				<h2 class="text-sm title-font text-gray-500 tracking-widest">{product.brand}</h2>
				<h1 class="text-white text-3xl title-font font-medium mb-1">{product.name}</h1>
				<div class="flex mb-4">
					<span class="flex items-center">
						<!-- <StarRating rating={product.rating} /> -->
						<StarRating {config} />
						<span class="ml-3">{product.rating_cnt} Reviews</span>
					</span>
				</div>
				<p class="leading-relaxed">
					{product.description}
				</p>
				<div class="flex mt-6 items-center pb-5 border-b-2 border-gray-800 mb-5">
					<div class="flex" />
				</div>
				<div class="flex">
					<span class="title-font font-medium text-2xl text-white">₹{product.price}</span>
					<ProductButton name="Buy Now" color="teal"/>
					<button
						class="inline-flex items-center justify-center ml-4"
					>
                    <ProductButton name="Add to Cart" color="teal_outline" on:click={() => addToCart()}/>
					</button>
				</div>
			</div>
		</div>
	</div>
</div>