/**
 * \file scanner.l
 * \author Petr Velan <petr.velan@cesnet.cz>
 * \brief Flex ipfixdump filter scanner
 *
 * Copyright (C) 2011 CESNET, z.s.p.o.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 * 3. Neither the name of the Company nor the names of its contributors
 *    may be used to endorse or promote products derived from this
 *    software without specific prior written permission.
 *
 * ALTERNATIVELY, provided that this notice is retained in full, this
 * product may be distributed under the terms of the GNU General Public
 * License (GPL) version 2 or later, in which case the provisions
 * of the GPL apply INSTEAD OF those given above.
 *
 * This software is provided ``as is, and any express or implied
 * warranties, including, but not limited to, the implied warranties of
 * merchantability and fitness for a particular purpose are disclaimed.
 * In no event shall the company or contributors be liable for any
 * direct, indirect, incidental, special, exemplary, or consequential
 * damages (including, but not limited to, procurement of substitute
 * goods or services; loss of use, data, or profits; or business
 * interruption) however caused and on any theory of liability, whether
 * in contract, strict liability, or tort (including negligence or
 * otherwise) arising in any way out of the use of this software, even
 * if advised of the possibility of such damage.
 *
 */
%{
#include "typedefs.h"
%}
 
%option noyywrap nounput
/*nodefault*/

%%

%[a-zA-Z0-9]+		{ arg = yytext; return ipfixdump::COLUMN; }
e[0-9]+id[0-9]+(p[0-9]+)?		{ arg = yytext; return ipfixdump::RAWCOLUMN; }
" "+|\t+|\n+		{/* ignore spaces and newlines */}
[0-9]+[kKmMgGtT]{0,1}	{ arg = yytext; return ipfixdump::NUMBER; }
[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}	{ arg = yytext; return ipfixdump::IPv4; }
[0-9]{4}"/"[0-9]{2}"/"[0-9]{2}\.[0-9]{2}:[0-9]{2}:[0-9]{2}	{ arg = yytext; return ipfixdump::TIMESTAMP; }
">"|"<"|"="|"==" |
"=>"|"<="|">=" | 
"=>"|"!="			{ arg = yytext; return ipfixdump::CMP; }
AND|OR|and|or		{ arg = yytext; return ipfixdump::OPERATOR; }
"("|")"				{ arg = yytext; return ipfixdump::BRACKET; }
.					{ arg = yytext; return ipfixdump::OTHER; }

%%
 