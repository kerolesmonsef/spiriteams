<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Requests\CreateTenantRequest;
use Illuminate\Http\Request;
use App\Http\Services\TenantService;
use App\Models\Tenant;
use App\Traits\ApiResponser;

class TenantController extends Controller
{
    use ApiResponser;

    private TenantService $tenantService;

    public function __construct()
    {
        // $this->tenantService = app(TenantService::class);
    }


    public function createTenant(CreateTenantRequest $request)
    {
        ['tenant' => $tenant, 'domain' => $domain] = (new TenantService($request->all()))->build();

        return response()->json([
            'tenant' => $tenant,
            'domain' => $domain,
        ]);
    }


    public function getBaseUrl(Request $request)
    {

        $request->validate([
            'company_code'      => 'required',
        ]);

        $tenant =  Tenant::where('company_code', $request->company_code)->firstOrFail();
        $domain = $tenant->domains()->first();

        return $this->success([
            'basic_url'        => $domain['domain'],
        ], __('messages.LeadAddedUpdated'));
    }
}
