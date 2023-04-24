<script lang="ts">
	import FullWidthButton from '$lib/shared/buttons/FullWidthButton.svelte';
	import jwtStore from '$lib/jwt';
	import { PUBLIC_API_URL } from '$env/static/public';
	import SuccessAlert from '$lib/shared/alerts/SuccessAlert.svelte';



	let name: string = '';
	let phone: number = 0;
	let email: string = '';
	let password: string = '';
	let confirmPassword: string = '';
	let noMatch: boolean = false;
    let lat: number = 0;
    let long: number = 0;
	let display_alert: boolean = false;

	async function signUp(name: string, email: string, phone: number, password: string, lat: number, lon: number) {
		let role = 'customer';
		let res = await fetch(`${PUBLIC_API_URL}/signup`, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				name,
				email,
				phone,
				password,
				lat,
				lon,
				role
			})
		});
		let data = await res.json();
		console.log(data);
		if (data.status == 'success') {
		setTimeout(() => {
						display_alert = true;
					}, 1000);
		} else {
			alert('Account creation failed');
		}
	}
		

</script>


<section class="bg-gray-800">
	<div class="flex justify-center ">
		<div class="max-w-xl lg:max-w-3xl">
			<h1 class="text-xl font-bold leading-tight tracking-tight md:text-2xl text-white mt-20">
				Create new account
			</h1>

			<form on:submit|preventDefault={() => {
						if (noMatch == false) {
							signUp(name, email, phone, password, lat, long);
						}
					}} 
					class=" mt-5 grid grid-cols-6 gap-6">
				<div class="col-span-6 sm:col-span-3">
					<label for="First Name" class="block mb-2 text-sm font-medium text-white"
						>Name</label
					>
					<input
						bind:value={name}
						type="text"
						class=" sm:text-sm rounded-lg focus:ring-teal-600 focus:border-teal-600 block w-full p-2.5 bg-gray-700 border-gray-600 placeholder-gray-400 text-white "
						placeholder="John"
						required
						autocomplete="off"
					/>
				</div>

				<div class="col-span-6 sm:col-span-3">
					<label for="Phone number" class="block mb-2 text-sm font-medium text-white">Phone Number</label>
					<input
						bind:value={phone}
						type="number"
						class=" sm:text-sm rounded-lg focus:ring-teal-600 focus:border-teal-600 block w-full p-2.5 bg-gray-700 border-gray-600 placeholder-gray-400 text-white "
						placeholder="1234567890"
						required
						autocomplete="off"
					/>
				</div>

				<div class="col-span-6">
					<label for="email" class="block mb-2 text-sm font-medium text-white">Email</label>
					<input
						bind:value={email}
						type="email"
						class=" sm:text-sm rounded-lg focus:ring-teal-600 focus:border-teal-600 block w-full p-2.5 bg-gray-700 border-gray-600 placeholder-gray-400 text-white "
						placeholder="name@company.com"
						required
						autocomplete="off"
					/>
				</div>

                <div class="col-span-6 sm:col-span-3">
					<label for="Latitude" class="block mb-2 text-sm font-medium text-white"
						>Latitude</label
					>
					<input
						bind:value={lat}
						type="number"
                        step="any"
                        min="-90"
                        max="90"
						class=" sm:text-sm rounded-lg focus:ring-teal-600 focus:border-teal-600 block w-full p-2.5 bg-gray-700 border-gray-600 placeholder-gray-400 text-white "
						placeholder="John"
						required
						autocomplete="off"
					/>
				</div>

                <div class="col-span-6 sm:col-span-3">
					<label for="Longitude" class="block mb-2 text-sm font-medium text-white"
						>Longitude</label
					>
					<input
						bind:value={long}
						type="number"
                        step="any"
                        min="-180"
                        max="180"
						class=" sm:text-sm rounded-lg focus:ring-teal-600 focus:border-teal-600 block w-full p-2.5 bg-gray-700 border-gray-600 placeholder-gray-400 text-white "
						placeholder="John"
						required
						autocomplete="off"
					/>
				</div>

               

				<div class="col-span-6 sm:col-span-3">
					<label for="password" class="block mb-2 text-sm font-medium text-white">Password</label>
					<input
						bind:value={password}
						type="password"
						class=" sm:text-sm rounded-lg focus:ring-teal-600 focus:border-teal-600 block w-full p-2.5 bg-gray-700 border-gray-600 placeholder-gray-400 text-white "
						placeholder="••••••••"
						required
						autocomplete="off"
					/>
				</div>

				<div class="col-span-6 sm:col-span-3">
					<label for="confirm password" class="block mb-2 text-sm font-medium text-white"
						>Confirm Password</label
					>
					<input
						bind:value={confirmPassword}
						type="password"
						class=" sm:text-sm rounded-lg focus:ring-teal-600 focus:border-teal-600 block w-full p-2.5 bg-gray-700 border-gray-600 placeholder-gray-400 text-white "
						placeholder="••••••••"
						required
						autocomplete="off"
						on:focusout={() => {
							if (password == confirmPassword) {
								noMatch = false;
							} else {
								noMatch = true;
							}
						}}
					/>
				</div>

				{#if noMatch}
					<p class="text-sm font-light text-red-500 dark:text-red-400 col-span-6">
						Passwords do not match
					</p>
				{/if}

				<div class="col-span-6">
					<label for="MarketingAccept" class="flex gap-4">
						<input
							type="checkbox"
							id="MarketingAccept"
							name="marketing_accept"
							class="h-5 w-5 rounded-md border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-800 dark:focus:ring-offset-gray-900"
						/>

						<span class="text-sm text-gray-200">
							I want to receive emails about events, product updates and company announcements.
						</span>
					</label>
				</div>

				<div class="col-span-6">
					<p class="text-sm text-gray-400">
						By creating an account, you agree to our
						<a href="#" class="underline text-gray-200"> terms and conditions </a>
						and
						<a href="#" class="underline text-gray-200"> privacy policy </a>.
					</p>
				</div>

				<button
					type="submit"
					class="col-span-6 w-full flex text-sm items-center justify-center rounded-lg border border-transparent bg-teal-500 px-6 py-3 font-medium text-white shadow-sm hover:bg-teal-600 hover:text-gray-200 "
					
					>Sign up</button
				>

				<p class="text-sm font-light text-gray-400 col-span-6 mb-8">
					Already have an account? <a
						class="font-medium  hover:underline text-teal-500 "
						href="/login"
					>
						Sign in
					</a>
				</p>
			</form>
			{#if display_alert}
				<SuccessAlert>
					Account Created Successfully
				</SuccessAlert>
			{/if}
		</div>
	</div>
</section>
