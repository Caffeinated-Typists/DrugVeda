export async function load({ fetch, params, url}) {
    let page = url.searchParams.get('from');

    return {'page': page};
}