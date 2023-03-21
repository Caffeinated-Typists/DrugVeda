import { sveltekit } from '@sveltejs/kit/vite';
import type { UserConfig } from 'vite';
import svg from '@poppanator/sveltekit-svg'


const config: UserConfig = {
	plugins: [
		sveltekit(),
		svg()
	]
};

export default config;
