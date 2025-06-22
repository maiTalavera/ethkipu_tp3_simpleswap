// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.26;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
}

contract SimpleSwap {

    struct Pool {
        uint reserveA;
        uint reserveB;
    }

    mapping(bytes32 => Pool) public pools;
    mapping(address => mapping(bytes32 => uint)) public lpBalances;
    mapping(bytes32 => uint) public totalLPSupply;

    // Función para obtener el ID único del par de tokens (orden independiente)
    function _getPoolId(address tokenA, address tokenB) internal pure returns (bytes32) {
        return tokenA < tokenB
            ? keccak256(abi.encodePacked(tokenA, tokenB))
            : keccak256(abi.encodePacked(tokenB, tokenA));
    }

    // Agregar liquidez
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity) {
        require(block.timestamp <= deadline, "Transaction expired");

        bytes32 poolId = _getPoolId(tokenA, tokenB);
        Pool storage pool = pools[poolId];

        if (pool.reserveA == 0 && pool.reserveB == 0) {
            // Primer depósito
            amountA = amountADesired;
            amountB = amountBDesired;
        } else {
            // Mantener proporción
            uint amountBOptimal = (amountADesired * pool.reserveB) / pool.reserveA;
            if (amountBOptimal <= amountBDesired) {
                require(amountBOptimal >= amountBMin, "Insufficient B amount");
                amountA = amountADesired;
                amountB = amountBOptimal;
            } else {
                uint amountAOptimal = (amountBDesired * pool.reserveA) / pool.reserveB;
                require(amountAOptimal >= amountAMin, "Insufficient A amount");
                amountA = amountAOptimal;
                amountB = amountBDesired;
            }
        }

        // Transferir tokens del usuario al contrato
        require(IERC20(tokenA).transferFrom(msg.sender, address(this), amountA), "Transfer A failed");
        require(IERC20(tokenB).transferFrom(msg.sender, address(this), amountB), "Transfer B failed");

        // Actualizar reservas
        pool.reserveA += amountA;
        pool.reserveB += amountB;

        // Calcular liquidez emitida
        liquidity = amountA + amountB;
        lpBalances[to][poolId] += liquidity;
        totalLPSupply[poolId] += liquidity;
        return (amountA, amountB, liquidity);
    }

    // Remover liquidez
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB) {
        require(block.timestamp <= deadline, "Transaction expired");

        bytes32 poolId = _getPoolId(tokenA, tokenB);
        Pool storage pool = pools[poolId];

        require(liquidity > 0, "Liquidity must be > 0");
        require(lpBalances[msg.sender][poolId] >= liquidity, "Not enough liquidity");

        uint totalLiquidity = totalLPSupply[poolId];

        amountA = (liquidity * pool.reserveA) / totalLiquidity;
        amountB = (liquidity * pool.reserveB) / totalLiquidity;

        require(amountA >= amountAMin, "Insufficient amount A");
        require(amountB >= amountBMin, "Insufficient amount B");

        pool.reserveA -= amountA;
        pool.reserveB -= amountB;

        lpBalances[msg.sender][poolId] -= liquidity;
        totalLPSupply[poolId] -= liquidity;

        require(IERC20(tokenA).transfer(to, amountA), "Transfer A failed");
        require(IERC20(tokenB).transfer(to, amountB), "Transfer B failed");
    }

    // Swap exact tokens for tokens
    function swapExactTokensForTokens(
    uint amountIn,
    uint amountOutMin,
    address[] calldata path,
    address to,
    uint deadline
) external returns (uint[] memory amounts) {
    require(path.length == 2, "Only direct swap supported");
    require(block.timestamp <= deadline, "Transaction expired");

    bytes32 poolId = _getPoolId(path[0], path[1]);
    Pool storage pool = pools[poolId];

    uint reserveIn;
    uint reserveOut;

    if (path[0] < path[1]) {
        reserveIn = pool.reserveA;
        reserveOut = pool.reserveB;
    } else {
        reserveIn = pool.reserveB;
        reserveOut = pool.reserveA;
    }

    uint amountOut = getAmountOut(amountIn, reserveIn, reserveOut);
    require(amountOut >= amountOutMin, "Insufficient output amount");

    require(IERC20(path[0]).transferFrom(msg.sender, address(this), amountIn), "Transfer in failed");
    require(IERC20(path[1]).transfer(to, amountOut), "Transfer out failed");

    if (path[0] < path[1]) {
        pool.reserveA += amountIn;
        pool.reserveB -= amountOut;
    } else {
        pool.reserveB += amountIn;
        pool.reserveA -= amountOut;
    }

    amounts = new uint[](2);
    amounts[0] = amountIn;
    amounts[1] = amountOut;
}


    // Calcula cantidad a recibir con fórmula Uniswap y fee 0.3%
    function getAmountOut(
        uint amountIn,
        uint reserveIn,
        uint reserveOut
    ) public pure returns (uint amountOut) {
        require(amountIn > 0 && reserveIn > 0 && reserveOut > 0, "Invalid amounts");

        uint amountInWithFee = amountIn * 997;
        uint numerator = amountInWithFee * reserveOut;
        uint denominator = (reserveIn * 1000) + amountInWithFee;
        amountOut = numerator / denominator;
    }

    // Obtener precio de tokenA en tokenB
    function getPrice(address tokenA, address tokenB) external view returns (uint price) {
        bytes32 poolId = _getPoolId(tokenA, tokenB);
        Pool storage pool = pools[poolId];
        require(pool.reserveA > 0 && pool.reserveB > 0, "No liquidity");

        if (tokenA < tokenB) {
            price = (pool.reserveB * 1e18) / pool.reserveA;
        } else {
            price = (pool.reserveA * 1e18) / pool.reserveB;
        }
    }
}
