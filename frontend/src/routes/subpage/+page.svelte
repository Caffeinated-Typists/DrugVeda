<script lang="ts">
	import { PUBLIC_API_URL } from '$env/static/public';
	import DataTable from '$lib/misc/DataTable.svelte';
	import DefaultButton from '$lib/shared/buttons/DefaultButton.svelte';
	import {
		Accordion,
		AccordionItem
	} from 'flowbite-svelte';

	let api_data: any[] = [];
	let show_table: boolean = false;
	let order_id: string = '';
	let supp_id: string = '';

	$: supp_id = '';

	async function api_call_no_param(param: string) {
		const response = await fetch(`${PUBLIC_API_URL}/deadline/${param}`);
		const data = await response.json();
		api_data = data.data;
		console.log(api_data);
		show_table = true;
	}

	async function api_call_with_param(param: string, id?: string) {
		console.log(id);
		const response = await fetch(`${PUBLIC_API_URL}/deadline/${param}/${id}`);
		const data = await response.json();
		api_data = data.data;
		console.log(api_data);
		show_table = true;
	}
</script>

<Accordion activeClasses="hover:bg-gray-600 text-white" inactiveClasses="hover:bg-gray-700">
	<AccordionItem class="">
		<span slot="header">Current inventory for all the retailers</span>
		<!-- <p class="mb-2 text-gray-400">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Illo ab necessitatibus sint explicabo ...</p>
      <p class="text-gray-400">Check out this guide to learn how to <a href="/" target="_blank" rel="noreferrer" class="text-blue-600 dark:text-blue-500 hover:underline">get started</a> and start developing websites even faster with components on top of Tailwind CSS.</p> -->
		<DefaultButton color="teal" on:click={() => api_call_no_param('OLAP1')}
			>Current inventory for all the retailers</DefaultButton
		>
		<DefaultButton
			color="teal_outline"
			on:click={() => {
				show_table = false;
				api_data = [];
			}}>Clear Data</DefaultButton
		>
		{#if show_table}
			<DataTable tableData={api_data} />
		{/if}
	</AccordionItem>
	<AccordionItem>
		<span slot="header">hHstory of all products supplied by a supplier</span>
		<DefaultButton color="teal" on:click={() => api_call_with_param('OLAP2', supp_id)}
			>hHstory of all products supplied by a supplier</DefaultButton
		>
		<DefaultButton
			color="teal_outline"
			on:click={() => {
				show_table = false;
				api_data = [];
			}}>Clear Data</DefaultButton
		>
		<input
			type="text"
			id="last_name"
			class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
			placeholder="Supplier ID"
			required
      bind:value={supp_id}
		/>

		{#if show_table}
			<DataTable tableData={api_data} />
		{/if}
	</AccordionItem>
	<AccordionItem>
		<span slot="header">Average rating of all the products</span>
		<DefaultButton color="teal" on:click={() => api_call_no_param('OLAP3')}
			>Average rating of all the products</DefaultButton
		>
		<DefaultButton
			color="teal_outline"
			on:click={() => {
				show_table = false;
				api_data = [];
			}}>Clear Data</DefaultButton
		>
		{#if show_table}
			<DataTable tableData={api_data} />
		{/if}
	</AccordionItem>

	<AccordionItem>
		<span slot="header">Sales of all the products by all the retailers</span>
		<DefaultButton color="teal" on:click={() => api_call_no_param('OLAP4')}
			>Sales of all the products by all the retailers</DefaultButton
		>
		<DefaultButton
			color="teal_outline"
			on:click={() => {
				show_table = false;
				api_data = [];
			}}>Clear Data</DefaultButton
		>
		{#if show_table}
			<DataTable tableData={api_data} />
		{/if}
	</AccordionItem>

	<AccordionItem>
		<span slot="header">Number of orders placed by each customer</span>
		<DefaultButton color="teal" on:click={() => api_call_no_param('EmbeddedSQL1')}
			>Number of orders placed by each customer</DefaultButton
		>
		<DefaultButton
			color="teal_outline"
			on:click={() => {
				show_table = false;
				api_data = [];
			}}>Clear Data</DefaultButton
		>
		{#if show_table}
			<DataTable tableData={api_data} />
		{/if}
	</AccordionItem>

	<AccordionItem>
		<span slot="header">Pending orders of each retailer</span>
		<DefaultButton color="teal" on:click={() => api_call_no_param('EmbeddedSQL2')}
			>Pending orders of each retailer</DefaultButton
		>
		<DefaultButton
			color="teal_outline"
			on:click={() => {
				show_table = false;
				api_data = [];
			}}>Clear Data</DefaultButton
		>
		{#if show_table}
			<DataTable tableData={api_data} />
		{/if}
	</AccordionItem>

	<AccordionItem>
		<span slot="header"
			>Update the order status to Delivered for Retail Order with provided OrderID</span
		>
		<DefaultButton color="teal" on:click={() => api_call_with_param('Trigger1', order_id)}
			>Run Query</DefaultButton
		>
		<input
			type="text"
			id="order_id"
			class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
			placeholder="Order ID"
			required
      bind:value={order_id}
		/>
	</AccordionItem>

	<AccordionItem>
		<span slot="header"
			>Update the order status to Delivered for Supply Order with provided OrderID</span
		>
		<DefaultButton color="teal" on:click={() => api_call_with_param('Trigger2', order_id)}
			>Run Query</DefaultButton
		>
		<input
			type="text"
			id="order_id"
			class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
			placeholder="Order ID"
			required
      bind:value={order_id}
		/>	</AccordionItem>
</Accordion>
