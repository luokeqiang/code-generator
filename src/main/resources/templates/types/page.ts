/**
 * 分页查询请求对象
 */
export interface PageRequest {
	/**
	 * 当前页
	 */
	current: number
	/**
	 * 每页显示数量
	 */
	size: number
}

/**
 * 分页查询响应对象
 */
export interface PageResponse<T> {
	/**
	 * 总数
	 */
	total: number
	/**
	 * 分页数据
	 */
	record: T[]
}
