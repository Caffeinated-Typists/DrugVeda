import { PUBLIC_API_URL } from '$env/static/public';

// passing the fetch function to the load function
export async function load({ fetch }) {
    // we converted the indidual fetch functions into a their own fetch function
    // so we can pass it to the load function, which only calls when we need to fetch that data    
    async function fetchCategories(){
        let categoriesRes = (await fetch(`${PUBLIC_API_URL}/categories`));
        let categoriesData = await categoriesRes.json();
        
        return categoriesData;
    }
    
    
    
    return {
        categories: fetchCategories()
    };
}