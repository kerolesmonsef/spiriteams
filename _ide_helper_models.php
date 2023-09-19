<?php

// @formatter:off

/**
 * A helper file for your Eloquent Models
 * Copy the phpDocs from this file to the correct Model,
 * And remove them from this file, to prevent double declarations.
 *
 * @author Barry vd. Heuvel <barryvdh@gmail.com>
 */


namespace Illuminate\Database\Eloquent {

    use Illuminate\Contracts\Pagination\CursorPaginator;
    use Illuminate\Contracts\Pagination\LengthAwarePaginator;

    /**
     * @method static \Illuminate\Database\Eloquent\Model|$this create(array $data)
     * @method static bool update(array $data)
     * @method static bool insert(array $data)
     * @method static Builder whereIn($column, $values, $boolean = 'and', $not = false)
     * @method static Builder latest(string $column)
     * @method static Builder where($column, $operation, $value = false)
     * @method static LengthAwarePaginator paginate($perPage = null, $columns = ['*'], $pageName = 'page', $page = null)
     * @method static CursorPaginator cursorPaginate($perPage = null, $columns = ['*'], $cursorName = 'cursor', $cursor = null)
     * @method static $this  orderByDesc($column)
     * @method static Model|$this|self|static find(int | array $id)
     * @method static Model|$this|self|static first()
     * @method static Model|$this|self|static findOrFail(int | array $id)
     * @mixin Model
     */
    class Model
    {
    }
}

namespace Illuminate\Contracts\Routing {
    /**
     * Interface ResponseFactory
     * @package Illuminate\Contracts\Routing
     * @method success($extra = [])
     * @method fail($extra = [], $code = 4000)
     */
    interface ResponseFactory
    {
    }
}

namespace Illuminate\Redis\Connections {
    /**
     * Class Connection
     * @package Illuminate\Redis\Connections
     * @method publish(string $chanel, string $data)
     */
    class Connection
    {

    }
}

namespace Illuminate\Contracts\Pagination {

    use Illuminate\Database\Eloquent\Collection;

    /**
     * @method Collection getCollection()
     */
    interface LengthAwarePaginator
    {
    }
}
