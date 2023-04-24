import { PUBLIC_API_URL } from '$env/static/public';
import type { LabTest } from '$lib/interfaces.js';

// passing the fetch function to the load function
export async function load({ fetch, params, url }) {
    // we converted the indidual fetch functions into a their own fetch function
    // so we can pass it to the load function, which only calls when we need to fetch that data    
    const testid = url.searchParams.get('id');

    async function fetchTest(){
        let testRes = (await fetch(`${PUBLIC_API_URL}/test`));
        let testData = await testRes.json();
        let testList = testData.data;

        let currTtest = testList.find((test: LabTest) => test.id === testid);
        return currTtest;
    }
    
    
    
    return {
        test: fetchTest()
    };
}