/**
 * Macros for metaprogramming
 * ExtendedC
 *
 * Copyright (C) 2012 Justin Spahr-Summers
 * Released under the MIT license
 */

/**
 * Executes one or more expressions (which may have a void type, such as a call
 * to a function that returns no value) and always returns true.
 */
#define metamacro_exprify(...) \
((__VA_ARGS__), true)

/**
 * Returns a string representation of VALUE after full macro expansion.
 */
#define metamacro_stringify(VALUE) \
metamacro_stringify_(VALUE)

/**
 * Returns A and B concatenated after full macro expansion.
 */
#define metamacro_concat(A, B) \
metamacro_concat_(A, B)

/**
 * Returns the Nth variadic argument (starting from zero). At least
 * N + 1 variadic arguments must be given. N must be between zero and twenty,
 * inclusive.
 */
#define metamacro_at(N, ...) \
metamacro_concat(metamacro_at, N)(__VA_ARGS__)

/**
 * Returns the number of arguments (up to twenty) provided to the macro. At
 * least one argument must be provided.
 *
 * Inspired by P99: http://p99.gforge.inria.fr
 */
#define metamacro_argcount(...) \
metamacro_at(20, __VA_ARGS__, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1)

/**
 * Returns the first argument given. At least one argument must be provided.
 *
 * This is useful when implementing a variadic macro, where you may have only
 * one variadic argument, but no way to retrieve it (for example, because \c ...
 * always needs to match at least one argument).
 *
 * @code
 
 #define varmacro(...) \
 metamacro_head(__VA_ARGS__)
 
 * @endcode
 */
#define metamacro_head(...) \
metamacro_head_(__VA_ARGS__, 0)

/**
 * Decrements VAL, which must be a number between zero and twenty, inclusive.
 *
 * This is primarily useful when dealing with indexes and counts in
 * metaprogramming.
 */
#define metamacro_dec(VAL) \
metamacro_at(VAL, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19)



#define metamacro_if_eq(A, B) \
metamacro_concat(metamacro_if_eq, A)(B)



// IMPLEMENTATION DETAILS FOLLOW!
// Do not write code that depends on anything below this line.
#define metamacro_stringify_(VALUE) # VALUE
#define metamacro_concat_(A, B) A ## B
#define metamacro_foreach_iter(INDEX, MACRO, ARG) MACRO(INDEX, ARG)
#define metamacro_head_(FIRST, ...) FIRST
#define metamacro_tail_(FIRST, ...) __VA_ARGS__
#define metamacro_consume_(...)
#define metamacro_expand_(...) __VA_ARGS__

// metamacro_at expansions
#define metamacro_at0(...) metamacro_head(__VA_ARGS__)
#define metamacro_at1(_0, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at2(_0, _1, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at3(_0, _1, _2, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at4(_0, _1, _2, _3, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at5(_0, _1, _2, _3, _4, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at6(_0, _1, _2, _3, _4, _5, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at7(_0, _1, _2, _3, _4, _5, _6, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at8(_0, _1, _2, _3, _4, _5, _6, _7, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at9(_0, _1, _2, _3, _4, _5, _6, _7, _8, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at10(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at11(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at12(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at13(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at14(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at15(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at16(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at17(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at18(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at19(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, ...) metamacro_head(__VA_ARGS__)
#define metamacro_at20(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, ...) metamacro_head(__VA_ARGS__)

// metamacro_foreach_cxt expansions
#define metamacro_foreach_cxt0(MACRO, SEP, CONTEXT)
#define metamacro_foreach_cxt1(MACRO, SEP, CONTEXT, _0) MACRO(0, CONTEXT, _0)


// metamacro_if_eq expansions
#define metamacro_if_eq0(VALUE) \
metamacro_concat(metamacro_if_eq0_, VALUE)

#define metamacro_if_eq0_0(...) __VA_ARGS__ metamacro_consume_
#define metamacro_if_eq0_1(...) metamacro_expand_

#define metamacro_if_eq1(VALUE) metamacro_if_eq0(metamacro_dec(VALUE))


#define keypath(...) \
metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__))(keypath1(__VA_ARGS__))(keypath2(__VA_ARGS__))

#define keypath1(PATH) \
(((void)(NO && ((void)PATH, NO)), strchr(# PATH, '.') + 1))

#define keypath2(OBJ, PATH) \
(((void)(NO && ((void)OBJ.PATH, NO)), # PATH))
