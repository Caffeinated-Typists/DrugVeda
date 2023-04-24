<script lang='ts'>
	import FullWidthButton from "$lib/shared/buttons/FullWidthButton.svelte";
	import { PUBLIC_API_URL } from "$env/static/public";
	import jwtStore from "$lib/jwt";
	import { onMount } from "svelte";
	import SuccessAlert from "$lib/shared/alerts/SuccessAlert.svelte";
	
	export let data;
	let jwt: string = '';
	let display_alert = false;
	onMount(() => {
		jwtStore.subscribe((value) => {
			jwt = value;
		});
		if (jwt != '') {
			window.location.href = '/';
		}
	});

	let email:string = '';
	let password:string = '';
	let register:boolean = false;
	let confirmPassword:string = '';
	let noMatch:boolean = false;


	async function login(email: string, password: string) {
		let role = 'customer';
		let res = await fetch(`${PUBLIC_API_URL}/login`, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				email,
				password
			})
		});
		let res_data = await res.json();
		console.log(res_data.token);
		if (res_data.status === 'success' && res_data.token != null) {
			jwt = res_data.token;
			jwtStore.set(jwt);
		} else {
			alert('Invalid credentials');
		}

		if (jwt != '') {
			setTimeout(() => {
				display_alert = true;
			}, 1000);
		}
	}

</script>

<section class="bg-gray-800 mt-20">
	<div class="flex flex-col items-center justify-center px-6 py-8 mx-auto lg:py-0">
		<div
			class="w-full rounded-lg shadow dark:border md:mt-0 sm:max-w-md xl:p-0 bg-gray-800 border-gray-700"
		>
			<div class="p-6 space-y-4 md:space-y-6 sm:p-8">
				<h1
					class="text-xl font-bold leading-tight tracking-tight md:text-2xl text-white"
				>
					Sign in to your account
				</h1>

				<form class="space-y-4 md:space-y-6" on:submit={() => login(email, password)}>
					<div>
						<label for="email" class="block mb-2 text-sm font-medium text-white"
							>Your email</label
						>
						<input
							bind:value={email}
							type="email"	
							name="email"
							id="email"
							class=" sm:text-sm rounded-lg focus:ring-teal-600 focus:border-teal-600 block w-full p-2.5 bg-gray-700 border-gray-600 placeholder-gray-400 text-white "
							placeholder="name@company.com"
							required
							autocomplete="off"
						/>
					</div>
					<div>
						<label
							for="password"
							class="block mb-2 text-sm font-medium text-white">Password</label
						>
						<input
							bind:value={password}
							type="password"
							name="password"
							id="password"
							placeholder="••••••••"
							class=" sm:text-sm rounded-lg focus:ring-teal-600 focus:border-teal-600 block w-full p-2.5 bg-gray-700 border-gray-600 placeholder-gray-400 text-white"
							required
						/>
					</div>

					
					<div class="flex items-center justify-between">
						<div class="flex items-start">
							<div class="flex items-center h-5">
								<input
									id="remember"
									aria-describedby="remember"
									type="checkbox"
									class="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-teal-300 dark:bg-gray-700 dark:border-gray-600 dark:focus:ring-teal-600 dark:ring-offset-gray-800"
								/>
							</div>
							<div class="ml-3 text-sm">
								<label for="remember" class="text-gray-500 dark:text-gray-300">Remember me</label>
							</div>
						</div>
						<a
							href="#"
							class="font-medium  hover:underline text-teal-500 hover:text-teal-500"
							>Forgot password?</a
						>
					</div>


					<button
						type="submit"
						class="w-full flex text-sm items-center justify-center rounded-lg border border-transparent bg-teal-500 px-6 py-3 font-medium text-white shadow-sm hover:bg-teal-600 hover:text-gray-200 "
						>Sign up</button
					>

						<p class="text-sm font-light text-gray-500 dark:text-gray-400">
							Don't have an account yet? <a
								class="font-medium text-teal-500 hover:underline"
								href="/signup"
								>Sign up</a
							>
						</p>

				</form>
			</div>
			{#if display_alert}
		<SuccessAlert>
			Login Sucessful!!!
		</SuccessAlert>
	{/if}
		</div>
		
	</div>

</section>

