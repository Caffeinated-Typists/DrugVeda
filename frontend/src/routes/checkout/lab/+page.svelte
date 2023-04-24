<script lang="ts">
	import { browser } from "$app/environment";
    import LabCheckout from "$lib/components/LabCheckout.svelte";
    import { onMount } from "svelte";
    import labCartStore from "$lib/labCart";
    import jwtStore from "$lib/jwt";
    import type { CartItem, LabTest } from "$lib/interfaces";

    let cart: LabTest[] = [];
    let jwt: string = "";

    onMount(() => {
        labCartStore.subscribe((value) => {
            cart = value;
        });

        jwtStore.subscribe((value) => {
            jwt = value;
        });

        if (browser){
            if (jwt === null || jwt === ''){
                window.location.href = "/login?from=lab";
            }
        }

    });

    console.log(cart)
    




    
</script>


<LabCheckout cart={cart}/>