% !Mode:: "TeX:UTF-8"
%%%%% 'buaathesis.cls' BEGIN
%<@@=buaathesis>

%%%%%%%%%% class clarification %%%%%%%%%%
% 模板声明

\NeedsTeXFormat{LaTeX2e}[2023/11/01]
\ProvidesExplClass{buaathesis}{2024/02/17}{v0.10}{The LaTeX3 template for thesis of BUAA}

%\msg_new:nnn{buaathesis}{bootstrap/info}{
%    You ~ are ~ using ~ buaathesis ~ package ~ with ~ '#1' ~ (version~'#2')
%}

%\msg_info:nnVV{buaathesis}{bootstrap/info}{\c_sys_engine_format_str}{\c_sys_engine_version_str}

%%%%%%%%%% class options %%%%%%%%%%
% 模板选项

% 本模板自身包含五个选项
% 前四个为对应学位类型，决定不同样式
% 第五个为颜色选项，用于电子版的情况

\bool_gset_false:N \g_@@_bachelor_bool
\bool_gset_false:N \g_@@_master_bool
\bool_gset_false:N \g_@@_doctor_bool
\bool_gset_false:N \g_@@_professional_bool
\bool_gset_false:N \g_@@_classified_bool
\bool_gset_false:N \g_@@_color_bool
\bool_gset_false:N \g_@@_twoteacher_bool
\bool_gset_false:N \g_@@_proposal_bool

% Logo 位置
\tl_new:N \g_@@_logo_filename_tl
\tl_new:N \g_@@_name_filename_tl
\tl_new:N \g_@@_name_eng_filename_tl
\tl_gset:Nn \g_@@_logo_filename_tl {figure/buaamark.pdf}
\tl_gset:Nn \g_@@_name_chn_only_filename_tl {figure/buaaname_ch.pdf}
\tl_gset:Nn \g_@@_name_filename_tl {figure/buaaname.pdf}

\keys_define:nn{buaathesis}{
    bachelor        .code:n = { \bool_gset_true:N \g_@@_bachelor_bool },
    master          .code:n = { \bool_gset_true:N \g_@@_master_bool },
    doctor          .code:n = { \bool_gset_true:N \g_@@_doctor_bool },
    professional    .code:n = { \bool_gset_true:N \g_@@_professional_bool },
    classfied       .code:n = { \bool_gset_true:N \g_@@_classified_bool },
    color           .code:n = { \bool_gset_true:N \g_@@_color_bool },
    twoteacher      .code:n = { \bool_gset_true:N \g_@@_twoteacher_bool },
    ktreport        .code:n = { \bool_gset_true:N \g_@@_proposal_bool },
    % Pass unknown options to ctexbook
    unknown         .code:n = { \PassOptionsToClass{\CurrentOption}{ctexbook} }
}
\ProcessKeyOptions[buaathesis]

\bool_log:N \g_@@_bachelor_bool
\bool_log:N \g_@@_master_bool
\bool_log:N \g_@@_doctor_bool
\bool_log:N \g_@@_professional_bool
\bool_log:N \g_@@_classified_bool
\bool_log:N \g_@@_color_bool
\bool_log:N \g_@@_twoteacher_bool
\bool_log:N \g_@@_proposal_bool

\bool_if:nF { \g_@@_bachelor_bool || \g_@@_master_bool || \g_@@_doctor_bool } {
    \msg_new:nnn {buaathesis} {error/notselected} {
        None ~ of ~ the ~ degrees ~ is ~ selected. ~ Result ~ may ~ be ~ unexpected.
    }
    \msg_warning:nn {buaathesis} {error/notselected}
}
% 引用ctexbook及基本设置
\LoadClass[zihao=-4,a4paper]{ctexbook}[2007/10/19]

%%%%%%%%%% global package %%%%%%%%%%
% 全局通用宏包

\RequirePackage{ifthen}
\RequirePackage{amsmath,amssymb,amsfonts,bm}
\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}
\RequirePackage{txfonts}
\RequirePackage{hyphenat}
\RequirePackage{xcolor}
\RequirePackage{geometry}
\RequirePackage{titletoc}
\RequirePackage{booktabs}       % 设置三线表格的上下边为粗实线
\RequirePackage{longtable}      % 长表格
\RequirePackage{multirow}       % 表格中的行合并
\RequirePackage{fancyhdr}
\RequirePackage{tabularx}
\RequirePackage{array}
\RequirePackage{graphicx}
\RequirePackage{pifont}         % “秘级”后的五角星
\RequirePackage{subcaption}
\RequirePackage{enumitem}
\RequirePackage{listings}
\RequirePackage{dirtree}
\RequirePackage{caption}
\RequirePackage{ulem}           % 下划线
\RequirePackage{setspace}       % 设置行距

\RequirePackage[style=gb7714-2015, gbnamefmt=lowercase, backend=biber]{biblatex}

%%%%%%%%%% common user info %%%%%%%%%%
% 用户信息

% 学校名称
\tl_new:N \l_@@_university_name_tl
\tl_new:N \l_@@_university_name_eng_tl
\tl_set:Nn \l_@@_university_name_tl {北京航空航天大学}
\tl_set:Nn \l_@@_university_name_eng_tl {Beihang University}
\NewDocumentCommand{\university}{mm}{
    \tl_set:Nn \l_@@_university_name_tl {#1}
    \tl_set:Nn \l_@@_university_name_eng_tl {#2}
}
% 学院
\tl_new:N \l_@@_school_name_tl
\tl_new:N \l_@@_school_name_eng_tl
\NewDocumentCommand{\school}{mm}{
    \tl_set:Ne \l_@@_school_name_tl {#1}
    \tl_set:Ne \l_@@_school_name_eng_tl {#2}
}
% 专业
\tl_new:N \l_@@_major_tl
\tl_new:N \l_@@_major_eng_tl
\NewDocumentCommand{\major}{mm}{
    \tl_set:Ne \l_@@_major_tl {#1}
    \tl_set:Ne \l_@@_major_eng_tl {#2}
}
% 论文标题和副标题
\tl_new:N \l_@@_thesis_title_tl
\tl_new:N \l_@@_thesis_subtitle_tl
\tl_new:N \l_@@_thesis_title_eng_tl
\tl_new:N \l_@@_thesis_subtitle_eng_tl
\RenewDocumentCommand{\title}{mmmm}{
    \tl_set:Nn \l_@@_thesis_title_tl {#1}
    \tl_set:Nn \l_@@_thesis_subtitle_tl {#2}
    \tl_set:Nn \l_@@_thesis_title_eng_tl {#3}
    \tl_set:Nn \l_@@_thesis_subtitle_eng_tl {#4}
}
\NewCommandCopy{\thesistitle}{\title}
% 作者
\tl_new:N \l_@@_author_tl
\tl_new:N \l_@@_author_eng_tl
\RenewDocumentCommand{\author}{mm}{
    \tl_set:Nn \l_@@_author_tl {#1}
    \tl_set:Nn \l_@@_author_eng_tl {#2}
}
\NewCommandCopy{\thesisauthor}{\author}
% 指导老师
\tl_new:N \l_@@_teacher_tl
\tl_new:N \l_@@_teacher_eng_tl
\NewDocumentCommand{\teacher}{mm}{
    \tl_set:Nn \l_@@_teacher_tl {#1}
    \tl_set:Nn \l_@@_teacher_eng_tl {#2}
}
% 副指导老师
\tl_new:N \l_@@_teacher_two_tl
\tl_new:N \l_@@_teacher_two_eng_tl
\NewDocumentCommand{\subteacher}{mm}{
    \tl_set:Nn \l_@@_teacher_two_tl {#1}
    \tl_set:Nn \l_@@_teacher_two_eng_tl {#2}

    \regex_match:nnTF {.+}{ \tl_use:N \l_@@_teacher_two_tl }{
        \bool_gset_true:N \g_@@_twoteacher_bool

        \msg_new:nnn {buaathesis}{autotwoteacher}{
            subteacher~command~was~issued,~and~twoteacher~option~will~be~automatically~selected.
        }
        \msg_info:nn {buaathesis}{autotwoteacher}
    }{
        \msg_new:nnn {buaathesis}{notwoteacher}{
            subteacher~command~was~issued,~but~no~teacher~two~could~be~found.
        }
        \msg_warning:nn {buaathesis}{notwoteacher}
    }
}
% 分类号
\tl_new:N \l_@@_clc_number_tl
\NewDocumentCommand{\category}{m}{ \tl_set:Nn \l_@@_clc_number_tl {#1} }
% 论文开始时间
\tl_new:N \l_@@_thesis_begin_year_tl
\tl_new:N \l_@@_thesis_begin_month_tl
\tl_new:N \l_@@_thesis_begin_day_tl
\NewDocumentCommand{\thesisbegin}{mmm}{
    \tl_set:Nn \l_@@_thesis_begin_year_tl {#1}
    \tl_set:Nn \l_@@_thesis_begin_month_tl {#2}
    \tl_set:Nn \l_@@_thesis_begin_day_tl {#3}
}
% 论文结束时间
\tl_new:N \l_@@_thesis_end_year_tl
\tl_new:N \l_@@_thesis_end_month_tl
\tl_new:N \l_@@_thesis_end_day_tl
\NewDocumentCommand{\thesisend}{mmm}{
    \tl_set:Nn \l_@@_thesis_end_year_tl {#1}
    \tl_set:Nn \l_@@_thesis_end_month_tl {#2}
    \tl_set:Nn \l_@@_thesis_end_day_tl {#3}
}
% 答辩时间
\tl_new:N \l_@@_defense_year_tl
\tl_new:N \l_@@_defense_month_tl
\tl_new:N \l_@@_defense_day_tl
\NewDocumentCommand{\defense}{mmm}{
    \tl_set:Nn \l_@@_defense_year_tl {#1}
    \tl_set:Nn \l_@@_defense_month_tl {#2}
    \tl_set:Nn \l_@@_defense_day_tl {#3}
}
% 中文摘要关键字
\tl_new:N \l_@@_keyword_tl
\NewDocumentCommand{\ckeyword}{m}{ \tl_set:Nn \l_@@_keyword_tl {#1} }
% 英文摘要关键字
\tl_new:N \l_@@_keyword_eng_tl
\NewDocumentCommand{\ekeyword}{m}{ \tl_set:Nn \l_@@_keyword_eng_tl {#1} }
% 学位
\tl_new:N \l_@@_degree_long_tl      % 中文首页
\tl_new:N \l_@@_degree_long_eng_tl  % 英文首页
\tl_new:N \l_@@_degree_title_tl     % 题名页
\tl_new:N \l_@@_degree_head_tl      % 页眉页脚

\bool_if:NT \g_@@_bachelor_bool {
    \tl_set:Nn \l_@@_degree_long_tl {学士学位}
    \tl_set:Nn \l_@@_degree_long_eng_tl {Bachelor}
    \tl_set:Nn \l_@@_degree_title_tl {学士学位}
    \tl_set:Nn \l_@@_degree_head_tl {学士}
}
\bool_if:NT \g_@@_master_bool {
    \bool_if:NTF \g_@@_professional_bool {
        \tl_set:Nn \l_@@_degree_long_tl {专业硕士学位}
    } {
        \tl_set:Nn \l_@@_degree_long_tl {硕士学位}
    }
    \tl_set:Nn \l_@@_degree_long_eng_tl {Master}
    \tl_set:Nn \l_@@_degree_title_tl {硕士学位}
    \tl_set:Nn \l_@@_degree_head_tl {硕士}
}
\bool_if:NT \g_@@_doctor_bool {
    \bool_if:NTF \g_@@_professional_bool {
        \tl_set:Nn \l_@@_degree_long_tl {专业博士学位}
    } {
        \tl_set:Nn \l_@@_degree_long_tl {博士学位}
    }
    \tl_set:Nn \l_@@_degree_long_eng_tl {Doctor of Philosophy}
    \tl_set:Nn \l_@@_degree_title_tl {博士学位}
    \tl_set:Nn \l_@@_degree_head_tl {博士}
}

% 开题文件类别
\tl_new:N \l_@@_proposal_class_tl
\NewDocumentCommand{\ktclass}{m}{ \tl_set:Nn \l_@@_proposal_class_tl {#1} }

%%%%%%%%%% bachelor user info %%%%%%%%%%
% 本科生信息

% 班级
\tl_new:N \l_@@_class_tl
\NewDocumentCommand{\class}{m}{ \tl_set:Nn \l_@@_class_tl {#1} }
% 单位代码
\tl_new:N \l_@@_unit_code_tl
\tl_set:Nn \l_@@_unit_code_tl {1006}
\NewDocumentCommand{\unicode}{m}{ \tl_set:Nn \l_@@_unit_code_tl {#1} }
% 学号
\tl_new:N \l_@@_student_id_tl
\NewDocumentCommand{\studentID}{m}{ \tl_set:Nn \l_@@_student_id_tl{#1} }
% 论文时间
\tl_new:N \l_@@_bachelor_thesis_year_tl
\tl_new:N \l_@@_bachelor_thesis_month_tl
\NewDocumentCommand{\thesisdate}{mm}{
    \tl_set:Nn \l_@@_bachelor_thesis_year_tl {#1}
    \tl_set:Nn \l_@@_bachelor_thesis_month_tl {#2}
}

%%%%%%%%%% master user info %%%%%%%%%%
% 研究生信息

% 保密等级
\tl_new:N \l_@@_confidential_level_tl
\tl_new:N \l_@@_confidential_limit_tl
\NewDocumentCommand{\mibao}{mm}{
    \tl_set:Nn \l_@@_confidential_level_tl {#1}
    \tl_set:Nn \l_@@_confidential_limit_tl {#2}
}
% 研究方向
\tl_new:N \l_@@_direction_tl
\NewDocumentCommand{\direction}{m}{ \tl_set:Nn \l_@@_direction_tl {#1} }
% 导师职称
\tl_new:N \l_@@_teacher_title_tl
\tl_new:N \l_@@_teacher_title_eng_tl
\NewDocumentCommand{\teacherdegree}{mm}{
    \tl_set:Nn \l_@@_teacher_title_tl {#1}
    \tl_set:Nn \l_@@_teacher_title_eng_tl {#2}
}
% 副导师职称
\tl_new:N \l_@@_teacher_two_title_tl
\tl_new:N \l_@@_teacher_two_title_eng_tl
\NewDocumentCommand{\subteacherdegree}{mm}{
    \tl_set:Nn \l_@@_teacher_two_title_tl {#1}
    \tl_set:Nn \l_@@_teacher_two_title_eng_tl {#2}
}
% 申请学位级别(题名页)
\tl_new:N \l_@@_applied_degree_tl
\NewDocumentCommand{\applydegree}{m}{ \tl_set:Nn \l_@@_applied_degree_tl {#1} }
% 论文编号
\tl_new:N \l_@@_thesis_id_tl
\NewDocumentCommand{\thesisID}{m}{ \tl_set:Nn \l_@@_thesis_id_tl {#1} }
% 论文提交时间
\tl_new:N \l_@@_submission_year_tl
\tl_new:N \l_@@_submission_month_tl
\tl_new:N \l_@@_submission_day_tl
\NewDocumentCommand{\commit}{mmm}{
    \tl_set:Nn \l_@@_submission_year_tl {#1}
    \tl_set:Nn \l_@@_submission_month_tl {#2}
    \tl_set:Nn \l_@@_submission_day_tl {#3}
}
% 授予学位时间
\tl_new:N \l_@@_award_year_tl
\tl_new:N \l_@@_award_month_tl
\tl_new:N \l_@@_award_day_tl
\NewDocumentCommand{\award}{mmm}{
    \tl_set:Nn \l_@@_award_year_tl {#1}
    \tl_set:Nn \l_@@_award_month_tl {#2}
    \tl_set:Nn \l_@@_award_day_tl {#3}
}

%%%%%%%%%% font %%%%%%%%%%
% 数学相关和字体设置

%%%%%%%%%% hyphen %%%%%%%%%%
% For the `\hyp{}` command. Allow the user to insert `hyp{}` manually to
% adjust the line break when necessary.

% 主要字体为Times New Roman和宋体
% 模板某些标题需要华文行楷和32号字
\setmainfont{Times~New~Roman}
% 不需要设置CJKmainfont，ctex 宏包已经很好的处理了
% 不仅设置了粗体为黑体，斜体为楷体，还兼容了winfonts和adobefonts
% 直接设置反而会在只有adobefonts的情况下报错
% \setCJKmainfont{宋体}
% 重新定义了一下宋体和黑体，让其能支持textbf
% 华文行楷、华文楷体同上

\setCJKfamilyfont{songti}[AutoFakeBold = {2.17}]{宋体}
\setCJKfamilyfont{heiti}[AutoFakeBold = {2.17}]{黑体}
\setCJKfamilyfont{hwxingkai}[AutoFakeBold = {2.17}]{华文行楷}
\setCJKfamilyfont{hwkaiti}[AutoFakeBold = {2.17}]{华文楷体}
\DeclareDocumentCommand{\songti}{}{\CJKfamily{songti}}
\DeclareDocumentCommand{\heiti}{}{\CJKfamily{heiti}}
\DeclareDocumentCommand{\hwxingkai}{}{\CJKfamily{hwxingkai}}
\DeclareDocumentCommand{\hwkaiti}{}{\CJKfamily{hwkaiti}}

%%%%%%%%%% color %%%%%%%%%%
% 颜色设置

% 只用于电子版
\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}

%%%%%%%%%% page margin %%%%%%%%%%
% 页面边距

\newgeometry{
    top=30mm, bottom=25mm, left=30mm, right=20mm,
    headsep=5mm, includefoot
}
\savegeometry{bachelorgeometry}

% geometry for tasks pages for bachelor thesis, see also #270
\newgeometry{
    top=30mm, bottom=25mm, left=30mm, right=20mm,
    headsep=5mm
}
\savegeometry{bachelortaskgeometry}

\newgeometry{
    top=25mm, bottom=25mm, left=30mm, right=20mm,
    headsep=5mm, headheight=10mm, footskip=10mm,
}
\savegeometry{mastergeometry}

\bool_if:NTF \g_@@_bachelor_bool {
    \loadgeometry{bachelorgeometry}
}{
    \loadgeometry{mastergeometry}
}

%%%%%%%%%% space %%%%%%%%%%
% 其他间距

\renewcommand{\baselinestretch}{1.5}
\setlength{\parindent}{2em}
\setlength{\floatsep}{3pt~plus~3pt~minus~2pt}      % 图形之间或图形与正文之间的距离
\setlength{\abovecaptionskip}{10pt~plus~1pt~minus~1pt} % 图形中的图与标题之间的距离
\setlength{\belowcaptionskip}{3pt~plus~1pt~minus~2pt} % 表格中的表与标题之间的距离

%%%%%%%%%% header & footer %%%%%%%%%%
% 页眉页脚

% Force enter compat v3 mode when requires fancyhdr.
%
% There's chances after v3 that breaks BUAAThesis, see issue report:
%
%   https://github.com/BHOSC/BUAAthesis/issues/265
%
% and commit from fancyhdr
%
%   https://github.com/pietvo/fancyhdr/commit/00a7445aec70d3246de8faf108900d06e9caea1b
%
% The fix is tricky, but I think it is the best option we currently have...
%
\newif\iff@nch@compatViii
\let\f@nch@gbl\relax
\let\f@nch@gbl\global
    \f@nch@compatViiitrue

\fancypagestyle{frontmatter}{
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
    \fancyhf{}
    \fancyfoot[C]{\thepage}
}

\fancypagestyle{mainmatter}{
    \fancyhead{}
    \fancyfoot{}
    \bool_if:nT { \g_@@_bachelor_bool } {
        \bool_if:nTF {\g_@@_proposal_bool} {
            \fancyhead[C]{\zihao{-5}\hwkaiti
                \l_@@_degree_head_tl  学位论文\l_@@_proposal_class_tl\vspace{1.5mm}
            }
            \fancyfoot[C]{
                \hspace{1.5mm}
                \hwkaiti\zihao{-5}\l_@@_university_name_tl\l_@@_school_name_tl 学院
                \hfill\hfill
                \songti\zihao{-5}$\cdot$\quad\thepage\quad$\cdot$
                \hspace{1.5mm}
            }
            % 本科开题报告有页脚线
            \renewcommand{\footrulewidth}{0.4bp}
        } {
            \fancyhead[C]{
                \includegraphics[width=37bp]{\g_@@_logo_filename_tl}\hfill
                \raisebox{2ex}{\heiti\zihao{4}\l_@@_university_name_tl 毕业设计(论文)}\hfill
                \raisebox{2ex}{\songti\zihao{5}第\quad\thepage\quad 页}
            }
        }
    }

    \bool_if:nT { \g_@@_master_bool || \g_@@_doctor_bool } {
        \bool_if:nTF { \g_@@_proposal_bool } {
            % 研究生开题报告/文献综述，与本科生格式基本一致
            \fancyhead[C]{\zihao{-5}\hwkaiti
                \l_@@_degree_head_tl  学位论文\l_@@_proposal_class_tl\vspace{1.5mm}
            }
            \fancyfoot[C]{
                \hspace{1.5mm}
                \hwkaiti\zihao{-5}\l_@@_university_name_tl\l_@@_school_name_tl 学院
                \hfill\hfill
                \songti\zihao{-5}$\cdot$\quad\thepage\quad$\cdot$
                \hspace{1.5mm}
            }
            % 研究生开题报告有页脚线
            \renewcommand{\footrulewidth}{0.4bp}
        } {
            \legacy_if:nTF { @twoside } {
                \fancyhead[CO]{\zihao{-5}\songti
                    \l_@@_university_name_tl\l_@@_degree_head_tl  学位论文\vspace{1.5mm}
                }
                \fancyhead[CE]{\zihao{-5}\songti\leftmark\vspace{1.5mm}}
            } {
                \fancyhead[C]{\zihao{-5}\songti
                    \ifthenelse{\isodd{\value{page}}}
                        {\l_@@_university_name_tl\l_@@_degree_head_tl  学位论文}
                        {\leftmark}
                    \vspace{1.5mm}
                }
            }
            \fancyfoot[C]{\zihao{5}\thepage}
        }
    }
    \renewcommand{\headrulewidth}{0.5bp} % 页眉线宽度
}

\fancypagestyle{plain}{
    \pagestyle{fancy}
}

%%%%%%%%%% title %%%%%%%%%%
% 标题

% 汉化
\renewcommand{\contentsname}{\heiti\zihao{-2}\bfseries 目\qquad 录}
\renewcommand\listfigurename{\heiti\zihao{-2}\bfseries 插\ 图\ 目\ 录}
\renewcommand\listtablename{\heiti\zihao{-2}\bfseries 表\ 格\ 目\ 录}
\renewcommand\bibname{参\ 考\ 文\ 献}
\renewcommand{\figurename}{图}
\renewcommand{\tablename}{表}

% 格式
\ctexset{
    chapter={
        format={\centering\zihao{3}\heiti},
        nameformat={},
        aftername={\quad},
        titleformat={},
        beforeskip={-.5\baselineskip},
        afterskip={\baselineskip},
    },
    section={
        aftername={\quad},
        beforeskip={.5\baselineskip},
        afterskip={.5\baselineskip},
    },
    subsection={
        format={\zihao{-4}\heiti},
        aftername={\quad},
        beforeskip={.5\baselineskip},
        afterskip={.5\baselineskip},
    },
}

\bool_if:NTF \g_@@_bachelor_bool {
    \ctexset{
        chapter={
            name={,},
            number={\arabic{chapter}},
        },
        section={
            format={\zihao{-4}\heiti},
        },
    }
}{
    \ctexset{
        chapter={
            name={第,章},
            number={\chinese{chapter}},
        },
        section={
            format={\zihao{4}\heiti},
        },
    }
}

%%%%%%%%%% contents %%%%%%%%%%
% 目录

\bool_if:nTF \g_@@_bachelor_bool {
    \titlecontents{chapter}[0pt]{\heiti\zihao{-4}}{\thecontentslabel\ }{}
        {\hspace{.5em}\titlerule*[4pt]{$\cdot$}\contentspage}
    \titlecontents{section}[2em]{\vspace{0.1\baselineskip}\songti\zihao{-4}}{\thecontentslabel\ }{}
        {\hspace{.5em}\titlerule*[4pt]{$\cdot$}\contentspage}
    \titlecontents{subsection}[4em]{\vspace{0.1\baselineskip}\songti\zihao{-4}}{\thecontentslabel\ }{}
        {\hspace{.5em}\titlerule*[4pt]{$\cdot$}\contentspage}
} {
    \titlecontents{chapter}[0pt]{\vspace{-0.25\baselineskip}\heiti\zihao{4}}{\thecontentslabel\ }{}
        {\hspace{.5em}\titlerule*[4pt]{$\cdot$}{\zihao{-4}\contentspage}}[\vspace{0.07\baselineskip}]
    \titlecontents{section}[2em]{\songti\zihao{-4}}{\thecontentslabel\ }{}
        {\hspace{.5em}\titlerule*[4pt]{$\cdot$}{\zihao{-4}\contentspage}}[\vspace{0.1\baselineskip}]
    \titlecontents{subsection}[4em]{\vspace{-0.2\baselineskip}\songti\zihao{5}}{\thecontentslabel\ }{}
        {\hspace{.5em}\titlerule*[4pt]{$\cdot$}{\zihao{-4}\contentspage}}[\vspace{0.1\baselineskip}]
}


% 取消图片、表格目录中的章节空格
\addtocontents{lof}{\exp_not:n {\exp_not:n {\renewcommand{\addvspace}[1]{}}}}
\addtocontents{lot}{\exp_not:n {\exp_not:n {\renewcommand{\addvspace}[1]{}}}}

%表目录图目录的格式设置
%表目录与图目录数字前增加“表”与“图”字，并且使目录行间距与section行间距一致

\titlecontents{figure}[0pt]{\vspace{0.15\baselineskip}\songti\zihao{-4}}{\makebox[3em][l]{图~\thecontentslabel\quad}}{}
    {\hspace{.5em}\titlerule*[4pt]{$\cdot$}\contentspage}[\vspace{0.15\baselineskip}]

\titlecontents{table}[0pt]{\vspace{0.15\baselineskip}\songti\zihao{-4}}{\makebox[3em][l]{表~\thecontentslabel\quad}}{}
    {\hspace{.5em}\titlerule*[4pt]{$\cdot$}\contentspage}[\vspace{0.15\baselineskip}]
%%%%%%%%%% cross reference %%%%%%%%%%
% 交叉引用

% TODO: Update hyperref options
\RequirePackage[xetex,unicode]{hyperref}
\bool_if:NTF \g_@@_color_bool {
    \hypersetup{colorlinks}
} {
    \hypersetup{hidelinks}
}
\bool_if:NTF \g_@@_proposal_bool {
    \hypersetup{
        bookmarksnumbered,
        bookmarksopen,
        pdftitle={BUAA~thesis},
        pdfauthor={BHOSC},
        pdfsubject={北航毕业设计开题报告/文献综述},
        pdfcreator={LaTeXed~By~BHOSC}
    }
} {
    \hypersetup{
        bookmarksnumbered,
        bookmarksopen,
        pdftitle={BUAA~thesis},
        pdfauthor={BHOSC},
        pdfsubject={北航毕业设计论文},
        pdfcreator={LaTeXed~By~BHOSC}
    }
}

%%%%%%%%%% table %%%%%%%%%%
% 表格
% 重定义table/tabular/tabularx环境，使表格内为5号字
% TODO(huxuan): 支持 longtable
\let \oldtable \table
\let \endoldtable \endtable
\RenewDocumentEnvironment {table} {O{h!}} {
    \renewcommand{\arraystretch}{1.5}
    \zihao{5} \oldtable[#1]
}{
    \endoldtable
    \renewcommand{\arraystretch}{1}
}

% \let \oldtabular \tabular
% \let \endoldtabular \endtabular
% \RenewDocumentEnvironment {tabular} {om} {
%     \renewcommand{\arraystretch}{1.5}
%     \zihao{5} \oldtabular[#1]{#2}
% }{
%     \endoldtabular
%     \renewcommand{\arraystretch}{1} 
%     % tabular 不能以可展开的宏结束，否则会产生多余一行。
%     % https://tex.stackexchange.com/questions/5198/etoolbox-conditional-causes-unwanted-empty-row-in-tabular
% }

\let\oldtabularx\tabularx\relax
\let\endoldtabularx\endtabularx\relax
\RenewDocumentEnvironment {tabularx} {mm} {
    \renewcommand{\arraystretch}{1.5}
    \zihao{5} \oldtabularx{#1}{#2}
}{
    \endoldtabularx
    \renewcommand{\arraystretch}{1}
}

%%%%%%%%%% list %%%%%%%%%%
% 列表

\setlist{noitemsep}
\setlist[1,2]{labelindent=\parindent}
\setlist[enumerate,1]{label=\arabic*、}
\setlist[enumerate,2]{label=（\arabic*）}
\setlist{
    topsep=0pt,
    itemsep=0pt,
    partopsep=0pt,
    parsep=\parskip,
}

%%%%%%%%%% code %%%%%%%%%%
% 代码

% Listing 的设置请参考 http://en.wikibooks.org/wiki/LaTeX/Packages/Listings

\lstset{
    backgroundcolor=\color{white},
    basicstyle=\zihao{5}\ttfamily,
    columns=flexible,
    breakatwhitespace=false,
    breaklines=true,
    captionpos=b,
    frame=single,
    numbers=left,
    numbersep=5pt,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    stepnumber=1,
    rulecolor=\color{black},
    tabsize=2,
    texcl=true,
    title=\lstname,
    escapeinside={\%*}{*)},
    extendedchars=false,
    mathescape=true,
    xleftmargin=3em,
    xrightmargin=3em,
}

\bool_if:nTF \g_@@_color_bool {
    \lstset{
        numberstyle=\color{gray},
        keywordstyle=\color{blue},
        commentstyle=\color{dkgreen},
        stringstyle=\color{mauve},
    }
}{
    \lstset{
        numberstyle=\color{black},
        keywordstyle=\color{black},
        commentstyle=\color{black},
        stringstyle=\color{black},
    }
}

% 重命名Listings标题头
\renewcommand{\lstlistingname}{代码}

%%%%%%%%%% theorem %%%%%%%%%%
% 定理

\theoremsymbol{\ensuremath{\square}}
\newtheorem*{proof}{证明}
\theoremstyle{plain}
\theoremsymbol{}
\theoremseparator{：}
\newtheorem{assumption}{假设}[chapter]
\newtheorem{definition}{定义}[chapter]
\newtheorem{proposition}{命题}[chapter]
\newtheorem{lemma}{引理}[chapter]
\newtheorem{theorem}{定理}[chapter]
\newtheorem{axiom}{公理}[chapter]
\newtheorem{corollary}{推论}[chapter]
\newtheorem{exercise}{练习}[chapter]
\newtheorem{example}{例}[chapter]
\newtheorem{remark}{注释}[chapter]
\newtheorem{problem}{问题}[chapter]
\newtheorem{conjecture}{猜想}[chapter]

%%%%%%%%%% file directory %%%%%%%%%%
% 文件目录

\bool_if:nT \g_@@_color_bool {
    \renewcommand*\DTstylecomment{\ttfamily\color{dkgreen}}
    \renewcommand*\DTstyle{\ttfamily\color{red}}
}

%%%%%%%%%% caption %%%%%%%%%%
% 图表标题

\DeclareCaptionFormat{bachelorfigure}{\songti\zihao{5}{#1\textrm{#2}#3}}
\DeclareCaptionFormat{bachelortable}{\heiti\bf\zihao{5}{#1\textrm{#2}#3}}
\DeclareCaptionFormat{bachelorlstlisting}{\songti\bf\zihao{5}{#1\textrm{#2}#3}}
\DeclareCaptionFormat{masterfigure}{\bf\songti\zihao{5}{#1\textrm{#2}#3}}
\DeclareCaptionFormat{mastertable}{\bf\songti\zihao{5}{#1\textrm{#2}#3}}
\DeclareCaptionFormat{masterlstlisting}{\bf\songti\zihao{5}{#1\textrm{#2}#3}}

\bool_if:nTF \g_@@_bachelor_bool {
    % 本科无论是否是开题报告，图表序号都和章节有关
    \captionsetup[figure]{format=bachelorfigure,labelsep=quad}
    \captionsetup[table]{format=bachelortable,labelsep=quad}
    \captionsetup[lstlisting]{format=bachelorlstlisting,labelsep=quad}
    \renewcommand{\thefigure}{\arabic{chapter}.\arabic{figure}}
    \renewcommand{\thetable}{\arabic{chapter}.\arabic{table}}
    \renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}
} {
        % ktreport 中图标序号跟章节相关
    \bool_if:nTF \g_@@_proposal_bool {
        \captionsetup[figure]{format=masterfigure,labelsep=quad}
        \captionsetup[table]{format=mastertable,labelsep=quad}
        \captionsetup[lstlisting]{format=masterlstlisting,labelsep=quad}
        \renewcommand{\thefigure}{\arabic{chapter}.\arabic{figure}}
        \renewcommand{\thetable}{\arabic{chapter}.\arabic{table}}
        \renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}
    } {
        \@removefromreset{table}{chapter}
        \@removefromreset{figure}{chapter}
        %使图表的标号与章节无关
        \captionsetup[figure]{format=masterfigure,labelsep=quad}
        \captionsetup[table]{format=mastertable,labelsep=quad}
        \captionsetup[lstlisting]{format=masterlstlisting,labelsep=quad}
        \renewcommand{\thefigure}{\arabic{figure}}
        \renewcommand{\thetable}{\arabic{table}}
        \renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}
    }
}

% 图片表格标题命令，主要用于混排
\NewDocumentCommand{\figcaption}{}{
    \def\@captype{figure}\caption
}
\NewDocumentCommand{\tabcaption}{}{
    \def\@captype{table}\caption
}

%%%%%%%%%% other settings %%%%%%%%%%
% 杂项

% 设置<附录>的图表编号与当前附录章号关联
\cs_new:Nn \@@_cs_reset_counter_for_appendix: {
    % 图、表、公式编号随 chapter 清零
    \@addtoreset{figure}{chapter}
    \@addtoreset{table}{chapter}
    \@addtoreset{equation}{chapter}
    %图、表、公式编号章节关联
    \renewcommand{\thefigure}{
        \bool_if:NT {
            \int_compare_p:nNn { \c@chapter } > { 0 }
        } {
            \thechapter.
        }
        \@arabic\c@figure
    }
    \renewcommand{\thetable}{
        \bool_if:NT {
            \int_compare_p:nNn { \c@chapter } > { 0 }
        } {
            \thechapter.
        }
        \@arabic\c@table
    }
    \renewcommand{\theequation}{
        \bool_if:NT {
            \int_compare_p:nNn { \c@chapter } > { 0 }
        } {
            \thechapter.
        }
        \@arabic\c@equation
    }
}

\let\oldappendix\appendix
\renewcommand{\appendix}{
    \oldappendix
    \@@_cs_reset_counter_for_appendix:
}

% 正文前的页码设置位大写罗马数字
\renewcommand{\frontmatter}{
    \cleardoublepage
    \@mainmatterfalse
    \bool_if:nTF \g_@@_bachelor_bool {
        \pagenumbering{Roman}
    } {
        \pagenumbering{roman}
    }
}

% 保证偶数页结束章节
\cs_new:Nn \@@_cs_clear_page_ensure_even: {
    \clearpage
    \legacy_if:nT { @twoside } {
        \int_if_odd:nF { \c@page } {
            \hbox{} \thispagestyle{empty} \newpage
            \legacy_if:nT { @twocolumn } {
                \hbox{}\newpage
            }
        }
    }
}

%%%%%%%%%% index %%%%%%%%%%
% 首页

% 本科生首页的右上角和底部的填写内容居中
% cvrtc : CoVer - Right  - Top    - Center
% cvcbc : CoVer - Center - Bottom - Center

\cs_new:Npn \@@_cs_create_ubox_bf:nn #1#2 {
    \uline{ \makebox[#1][c]{ #2 } }
}
\cs_new:Npn \@@_cs_ulinecvrtc:n #1 { \@@_cs_create_ubox_bf:nn {9em} {#1} }
\cs_new:Npn \@@_cs_ulinecvcbc:n #1 { \@@_cs_create_ubox_bf:nn {14em} {#1} }

\cs_new:Nn \@@_cs_bachelor_proposal_tabular: {
    \begin{tabular}{c~p{0.55\textwidth}<{\raggedright}}
        \hwkaiti \textbf{论文题目}  : & \hwkaiti \l_@@_thesis_title_tl \\[.4ex]
        \hwkaiti \textbf{专 \hspace{2em} 业}  : & \hwkaiti \l_@@_major_tl \\[.4ex]
        \hwkaiti \textbf{姓 \hspace{2em} 名}  : & \hwkaiti \l_@@_author_tl \\[.4ex]
        \hwkaiti \textbf{学 \hspace{2em} 号}  : & \hwkaiti \l_@@_student_id_tl \\[.4ex]
        \hwkaiti \textbf{指导教师}  : & \hwkaiti\l_@@_teacher_tl
        \bool_if:NT \g_@@_twoteacher_bool { \quad \l_@@_teacher_two_tl }
        \\
    \end{tabular}
}
\cs_new:Nn \@@_cs_bachelor_tabular: {
    \begin{tabular}{cc}
        学 \hspace{0.75em} 院 \hspace{0.75em} 名 \hspace{0.75em} 称 \hspace{0.75em} &
        \@@_cs_ulinecvcbc:n {\l_@@_school_name_tl 学院} \\[.4ex]
        专 \hspace{0.75em} 业 \hspace{0.75em} 名 \hspace{0.75em} 称 \hspace{0.75em} &
        \@@_cs_ulinecvcbc:n {\l_@@_major_tl 专业} \\[.4ex]
        学 \hspace{0.75em} 生 \hspace{0.75em} 姓 \hspace{0.75em} 名 \hspace{0.75em} &
        \@@_cs_ulinecvcbc:n {\l_@@_author_tl} \\[.4ex]
        指 \hspace{0.75em} 导 \hspace{0.75em} 教 \hspace{0.75em} 师 \hspace{0.75em} &
        \@@_cs_ulinecvcbc:n {\l_@@_teacher_tl \bool_if:NT \g_@@_twoteacher_bool {\quad \l_@@_teacher_two_tl} } \\
    \end{tabular}
}
\cs_new:Nn \@@_cs_graduate_proposal_tabular: {
    \begin{tabular}{c~p{0.55\textwidth}<{\raggedright}}
        \hwkaiti \textbf{题 \hspace{2em} 目}  : 
        & \hwkaiti\l_@@_thesis_title_tl \\[.4ex]
        \hwkaiti \textbf{专 \hspace{2em} 业}  : 
        & \hwkaiti\l_@@_major_tl \\[.4ex]
        \hwkaiti \textbf{研究方向}  : 
        & \hwkaiti\l_@@_direction_tl \\[.4ex]
        \hwkaiti \textbf {
            \bool_case:n {
                { \g_@@_master_bool } {研 \hspace{0.5em} 究 \hspace{0.5em} 生}
                { \g_@@_doctor_bool } {博 \hspace{0.5em} 士 \hspace{0.5em} 生}
            }
        }  : 
        & \hwkaiti\l_@@_author_tl \\[.4ex]
        \hwkaiti \textbf{学 \hspace{2em} 号}  : 
        & \hwkaiti\l_@@_student_id_tl \\[.4ex]
        \hwkaiti \textbf{指导教师}  : 
        & \hwkaiti\l_@@_teacher_tl \bool_if:nT \g_@@_twoteacher_bool {\quad \l_@@_teacher_two_tl}\\
    \end{tabular}
}
\cs_new:Nn \@@_cs_graduate_tabular: {
    \begin{tabular}[b]{ll}
        作 \hspace{0.5em} 者 \hspace{0.5em} 姓 \hspace{0.5em} 名 \hspace{0.5em} & \l_@@_author_tl \\[.3ex]
        \bool_if:NTF \g_@@_professional_bool {
            专 \hspace{0.5em} 业 \hspace{0.5em} 名 \hspace{0.5em} 称 \hspace{0.5em} & \l_@@_major_tl\\[.3ex]
        } {
            学 \hspace{0.5em} 科 \hspace{0.5em} 专 \hspace{0.5em} 业 \hspace{0.5em} & \l_@@_major_tl\\[.3ex]
        }
        指 \hspace{0.5em} 导 \hspace{0.5em} 教 \hspace{0.5em} 师 \hspace{0.5em} & \l_@@_teacher_tl\quad\l_@@_teacher_title_tl 
        \bool_if:nT \g_@@_twoteacher_bool { 
            \\[.3ex] \hspace{0.5em} & \l_@@_teacher_two_tl\quad\l_@@_teacher_two_title_tl
        }
        \\[.3ex]
        培 \hspace{0.5em} 养 \hspace{0.5em} 学 \hspace{0.5em} 院 \hspace{0.5em} & \l_@@_school_name_tl 学院\\
    \end{tabular}
}
\cs_new:Nn \@@_cs_bachelor_proposal_cover_page: {
    \begin{titlepage}
        % 第二个()里的参数表示左移35pt，下移55pt
        \hfill \skip_vertical:n{45bp}
        \begin{center}
            \includegraphics[width=310bp]{\g_@@_name_filename_tl}
            \\ \skip_vertical:n{60bp} \mode_leave_vertical: \\
            \centerline{\zihao{1} \heiti \textbf{\l_@@_degree_long_tl 论文\l_@@_proposal_class_tl}}
            \mode_leave_vertical: \\ \skip_vertical:n{60bp} \mode_leave_vertical: \\
            { \zihao{-3} \heiti \@@_cs_bachelor_proposal_tabular: }
            \mode_leave_vertical: \\ \skip_vertical:n{75bp} \mode_leave_vertical: \\
            \centerline{
                \heiti\zihao{3}\textbf{\l_@@_university_name_tl \l_@@_school_name_tl 学院}
            }
            \skip_vertical:n{20bp}
            \centerline{
                \heiti\zihao{-3}
                \l_@@_bachelor_thesis_year_tl \hspace{0.5em} 年 \hspace{0.5em} 
                \l_@@_bachelor_thesis_month_tl \hspace{0.5em} 月
            }
        \end{center}
    \end{titlepage}
}
\cs_new:Nn \@@_cs_bachelor_cover_page: {
    \begin{titlepage}
        % 第二个()里的参数表示左移35pt，下移55pt
        \begin{picture}(0,0)(35,55)
            \includegraphics[width=90pt]{\g_@@_logo_filename_tl}
        \end{picture}
        \hfill
        \raisebox{-.2cm}[0pt][0pt]{
            \zihao{5}\heiti
            \begin{tabular}{c}
                单位代码 \hspace{0.25em} 
                \@@_cs_ulinecvrtc:n {\textbf{\l_@@_unit_code_tl}} \\[.1ex]
                学 \qquad 号 \hspace{0.25em} 
                \@@_cs_ulinecvrtc:n {\textbf{\l_@@_student_id_tl}} \\[.1ex]
                分 \hspace{0.5em} 类 \hspace{0.5em} 号 \hspace{0.25em} 
                \@@_cs_ulinecvrtc:n {\textbf{\l_@@_clc_number_tl}}\\
            \end{tabular}
        }
        \skip_vertical:n{95bp}
        \begin{center}
            \includegraphics[width=360bp]{\g_@@_name_filename_tl}
            \skip_vertical:n{45bp}
            \centerline{\zihao{-0}\heiti 毕业设计(论文)}
            \mode_leave_vertical: \\ \vspace*{\stretch{4}}
            \begin{minipage}[h]{.8\textwidth}
                \centering{\heiti\zihao{2}\l_@@_thesis_title_tl}
            \end{minipage}
            \skip_vertical:n{20bp}
            \begin{minipage}[h]{.75\textwidth}
                \centering{\heiti\zihao{3}\l_@@_thesis_subtitle_tl}
            \end{minipage}
            \vspace*{\stretch{3}} \mode_leave_vertical: \\
            {
                \zihao{-3}\heiti
                \@@_cs_bachelor_tabular:
            }
            \skip_vertical:n{60bp}
            \centerline{
                \heiti\zihao{-3}
                \l_@@_bachelor_thesis_year_tl \hspace{0.5em} 年 \hspace{0.5em} 
                \l_@@_bachelor_thesis_month_tl \hspace{0.5em} 月
            }
        \end{center}
    \end{titlepage}
}
\cs_new:Nn \@@_cs_graduate_proposal_cover_page: {
    \begin{titlepage}
        % 第二个()里的参数表示左移35pt，下移55pt
        \hfill \skip_vertical:n{45bp}
        \begin{center}
            \includegraphics[width=310bp]{\g_@@_name_filename_tl}
            \mode_leave_vertical: \\ \skip_vertical:n{60bp} \mode_leave_vertical: \\
            \centerline{\zihao{1} \heiti \textbf{\l_@@_degree_long_tl 论文\l_@@_proposal_class_tl}}
            \mode_leave_vertical: \\ \skip_vertical:n{60bp} \mode_leave_vertical: \\
            { \zihao{-3} \heiti \@@_cs_graduate_proposal_tabular: }
            \mode_leave_vertical: \\ \skip_vertical:n{75bp} \mode_leave_vertical: \\
            \centerline{\heiti\zihao{3}\textbf{\l_@@_university_name_tl\l_@@_school_name_tl 学院}}
            \skip_vertical:n{20bp}
            \centerline{
                \heiti\zihao{-3}
                \l_@@_bachelor_thesis_year_tl \hspace{0.5em} 年 \hspace{0.5em}
                \l_@@_bachelor_thesis_month_tl \hspace{0.5em} 月
            }
        \end{center}
    \end{titlepage}
}
\cs_new:Nn \@@_cs_graduate_cover_page: {
    \begin{titlepage}
        \begin{center}
            \begin{spacing}{1.5}
                {
                    \zihao{5}\heiti\bfseries
                    \begin{flushleft}
                        中图分类号：\l_@@_clc_number_tl  \\
                        论\,\,文\,\,编\,\,号：\l_@@_thesis_id_tl\\
                        \bool_if:nTF \g_@@_classified_bool {
                            \l_@@_confidential_level_tl\ding{73} \hspace{0.5em} \l_@@_confidential_limit_tl \\
                        } {
                            \skip_vertical:n{20bp}
                        }
                    \end{flushleft}
                }
                \skip_vertical:n{60bp}
                \includegraphics[width=.5\textwidth]{\g_@@_name_chn_only_filename_tl}
                \skip_vertical:n{30bp}
                \centerline{\zihao{0}\ziju{0.2}\hwxingkai\l_@@_degree_long_tl 论文}
                \mode_leave_vertical: \\
                %\vskip 100bp
                \vspace*{\stretch{5}}
                \begin{minipage}[h]{.85\textwidth}
                    \begin{spacing}{3}
                        % actually, it should be 1.5, but I think 3 will be prefect.
                        \centering{\zihao{-1}\songti\bfseries\l_@@_thesis_title_tl}
                    \end{spacing}
                \end{minipage} \par
                %\vspace{5bp}
                % the space between title and subtitle, however, it seems doesn't work.
                \begin{minipage}[h]{.75\textwidth}
                    \begin{spacing}{1.5}
                        \centering{\heiti\zihao{3}\l_@@_thesis_subtitle_tl}
                    \end{spacing}
                \end{minipage}
                \vspace*{\stretch{4}}
                \mode_leave_vertical: \\
                %\vskip 80bp
                {
                    \heiti\zihao{4}\ziju{0.2}
                    \@@_cs_graduate_tabular:
                }
            \end{spacing}
        \end{center}
    \end{titlepage}
}
% 中文首页
\cs_new:Nn \@@_cs_cover_page: {
    \bool_case:n {
        { \g_@@_bachelor_bool && \g_@@_proposal_bool } { \@@_cs_bachelor_proposal_cover_page: }
        { \g_@@_bachelor_bool } { \@@_cs_bachelor_cover_page: }
        { (\g_@@_master_bool || \g_@@_doctor_bool) && \g_@@_proposal_bool } { \@@_cs_graduate_proposal_cover_page: }
        { \g_@@_master_bool || \g_@@_doctor_bool } { \@@_cs_graduate_cover_page:}
    }
}

\cs_new:Nn \@@_cs_graduate_tabular_eng: {
    \begin{tabular}{ll}
        \textbf{Candidate:\ } & \textbf{\l_@@_author_eng_tl} \\[0.5ex]
        \textbf{Supervisor:\ } & \textbf{\l_@@_teacher_title_eng_tl \hspace{0.5em} \l_@@_teacher_eng_tl} 
        \bool_if:NT \g_@@_twoteacher_bool {
            \\ ~~ & \textbf{\l_@@_teacher_two_title_eng_tl \hspace{0.5em} \l_@@_teacher_two_eng_tl}
        } \\
    \end{tabular}
}
\cs_new:Nn \@@_cs_graduate_cover_page_eng: {
    \@@_cs_clear_page_ensure_even: \thispagestyle{empty}
    \vspace*{\stretch{1}}
    \begin{center}
        \begin{minipage}[h]{.8\textwidth}
            \begin{spacing}{2}
                \centering{ \zihao{-2} \textbf{\l_@@_thesis_title_eng_tl} }
            \end{spacing}
        \end{minipage}
        \skip_vertical:n {20bp}
        \begin{minipage}[h]{.75\textwidth}
            \centering{\zihao{-3}\l_@@_thesis_subtitle_eng_tl}
        \end{minipage}
        \vspace*{\stretch{1}} \mode_leave_vertical: \\
        {\zihao{4} A~Dissertation~Submitted~for~the~Degree~of~\l_@@_degree_long_eng_tl} \\
        \skip_vertical:n {110bp}
        \begin{center}
            \zihao{-3} \@@_cs_graduate_tabular_eng:
        \end{center}
        \skip_vertical:n {125bp}
        \zihao{3}{
            \l_@@_university_name_tl \\[1.8ex]
            \l_@@_university_name_eng_tl~,~Beijing,~China
        }
    \end{center}
}
% 英文首页

%%%%%%%%%% abstract %%%%%%%%%%
% 摘要
% 中文摘要
\NewDocumentEnvironment{cabstract}{}{
    \newpage \vspace*{2bp}
    \bool_if:NT \g_@@_bachelor_bool {
        \begin{center}
            \begin{minipage}[h]{.75\textwidth}
                \centering{\zihao{-3} \heiti \tl_use:N \l_@@_thesis_title_tl }
            \end{minipage} \par
            \begin{minipage}[h]{.8\textwidth}
                \begin{flushright}
                    {\zihao{-3} \heiti \tl_use:N \l_@@_thesis_subtitle_tl}
                \end{flushright}
            \end{minipage}
        \end{center}
        \begin{flushright}
            \begin{tabular}{cl}
                学~\qquad~生：& \tl_use:N \l_@@_author_tl \\
                指导教师：& \tl_use:N \l_@@_teacher_tl
                \bool_if:NT \g_@@_twoteacher_bool {
                    \\ ~~ & \tl_use:N \l_@@_teacher_two_tl
                } \\
            \end{tabular}
        \end{flushright}
    }
    \centerline{ \heiti \zihao{3} 摘~~~~要 }
    \bool_if:NTF \g_@@_bachelor_bool { \vskip 10bp \par }{ \vspace{5ex} }
    \setlength{\parindent}{24bp}
}{
    \vskip 21bp
    \bool_if:NT \g_@@_bachelor_bool {\noindent}
    { \heiti \zihao{-4} 关键词：} { \heiti \tl_use:N \l_@@_keyword_tl }
}

\NewDocumentEnvironment{eabstract}{}{
    \newpage \vspace*{2bp}
    \bool_if:NT \g_@@_bachelor_bool {
        \begin{center}
            \begin{minipage}[h]{.75\textwidth}
                \centering{ \bf \zihao{-3} \tl_use:N \l_@@_thesis_title_eng_tl }
            \end{minipage} \par
            \begin{minipage}[h]{.8\textwidth}
                \begin{flushright}
                    {\zihao{-3} \heiti \tl_use:N \l_@@_thesis_subtitle_eng_tl}
                \end{flushright}
            \end{minipage}
        \end{center} \vskip 10bp
        \begin{flushright}
            \begin{tabular}{rl}
                Author:\ & \tl_use:N \l_@@_author_eng_tl \\
                Tutor:\ & \tl_use:N \l_@@_teacher_eng_tl
                \bool_if:NT \g_@@_bachelor_bool {
                    \\ ~~ & \tl_use:N \l_@@_teacher_two_eng_tl
                } \\
            \end{tabular}
        \end{flushright}
    }
    \centerline{\bf\zihao{3} Abstract}
    \bool_if:NTF \g_@@_bachelor_bool {
        \vskip 10bp \par
    } {
        \vspace{5ex}
    }
    \setlength{\parindent}{24bp}
}{
    \vskip 21bp
    \bool_if:NT \g_@@_bachelor_bool {\noindent}
    {\bf\zihao{-4} Key~words:~} \tl_use:N \l_@@_keyword_eng_tl
}

%%%%%%%%%% announce %%%%%%%%%%
% 本科生声明页

\cs_new:Nn \@@_cs_bachelor_declaration_page: {
    \@@_cs_clear_page_ensure_even: \thispagestyle{empty} \vspace*{54bp}
    \centerline{\bf\zihao{-2}\songti 本人声明}
    \vskip 27bp
    \zihao{4} 我声明，本论文及其研究工作是由本人在导师指导下独立完成的，在完成论文时所利用的一
    切资料均已在参考文献中列出。
    \par \vskip 63bp
    \zihao{-4}
    \hfill
    \begin{tabular}{cl}
        作者：&\l_@@_author_tl\\
        签字：&~~~~\\
        时间：& \l_@@_bachelor_thesis_year_tl~年~\l_@@_bachelor_thesis_month_tl ~月
    \end{tabular}
}

%%%%%%%%%% assign %%%%%%%%%%
% 本科生任务书

% 文字左对齐的下划线
\NewDocumentCommand{\ulinel}{O{}m}{
    \uline{\makebox[#1\textwidth][l]{#2}}
}
% 文字居中的下划线
\NewDocumentCommand{\ulinec}{O{}m}{
    \uline{\makebox[#1\textwidth][c]{#2}}
}
% 任务书条目序号
\newcounter{assign}
% 原始资料及设计要求
\seq_new:N \l_@@_bachelor_asgnmt_requirement_seq 
\seq_new:N \l_@@_bachelor_asgnmt_work_seq
\seq_new:N \l_@@_bachelor_asgnmt_reference_seq
\NewDocumentCommand{\assignReq}{mmmmm}{
    \seq_clear:N \l_@@_bachelor_asgnmt_requirement_seq
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_requirement_seq {#1}
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_requirement_seq {#2}
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_requirement_seq {#3}
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_requirement_seq {#4}
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_requirement_seq {#5}
}
% 工作内容
\NewDocumentCommand{\assignWork}{mmmmmm}{
    \seq_clear:N \l_@@_bachelor_asgnmt_work_seq
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_work_seq {#1}
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_work_seq {#2}
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_work_seq {#3}
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_work_seq {#4}
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_work_seq {#5}
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_work_seq {#6}
}
% 参考文献
\NewDocumentCommand{\assignRef}{mmmmmmmm}{
    \seq_clear:N \l_@@_bachelor_asgnmt_reference_seq
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_reference_seq {#1}
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_reference_seq {#2}
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_reference_seq {#3}
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_reference_seq {#4}
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_reference_seq {#5}
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_reference_seq {#6}
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_reference_seq {#7}
    \seq_put_right:Nn \l_@@_bachelor_asgnmt_reference_seq {#8}
}
% 任务书

\cs_new:Npn \@@_cs_bachelor_assignment_page: {
    \newpage \thispagestyle{empty} \parindent=0pt \songti
    {
        \zihao{2}
        {
            \renewcommand{\CJKglue}{\hskip 1pt}
            \centerline{ \hwxingkai{ \tl_use:N \l_@@_university_name_tl } }
        }
        {
            \renewcommand{\CJKglue}{\hskip 1.2pt}
            \centerline{本科生毕业设计（论文）任务书}
        }
    }
    {
        \linespread{2} \zihao{4} \stepcounter{assign}
        \Roman{assign}、毕业设计（论文）题目： \\[2.5ex]
        \ulinel{ \tl_use:N \l_@@_thesis_title_tl } \\
        \ulinel{ \tl_use:N \l_@@_thesis_subtitle_tl } \\
        \ulinel{} \\

        \stepcounter{assign}
        \Roman{assign}、毕业设计（论文）使用的原始资料（数据）及设计技术要求： \\[2.5ex]
        \int_set:Nn \l_tmpa_int {1}
        \int_while_do:nNnn { \l_tmpa_int } < { 6 } {
            \ulinel{ \seq_item:NV \l_@@_bachelor_asgnmt_requirement_seq \l_tmpa_int } \\
            \int_incr:N \l_tmpa_int
        }
        
        \stepcounter{assign}
        \Roman{assign}、毕业设计（论文）工作内容： \\[2.5ex]
        \int_set:Nn \l_tmpa_int {1}
        \int_while_do:nNnn { \l_tmpa_int } < { 7 } {
            \ulinel{ \seq_item:NV \l_@@_bachelor_asgnmt_work_seq \l_tmpa_int }
            % 最后一行换行会溢出至下一页
            \int_compare:nNnT {\l_tmpa_int} < { 6 } { \\ }
            \int_incr:N \l_tmpa_int
        }

        \newpage \thispagestyle{empty} \begin{spacing}{1.9} \zihao{4}
        \stepcounter{assign}
        \Roman{assign}、主要参考资料： \\[1.5ex]
        \int_set:Nn \l_tmpa_int {1}
        \int_while_do:nNnn { \l_tmpa_int } < { 9 } {
            \ulinel{ \seq_item:NV \l_@@_bachelor_asgnmt_reference_seq \l_tmpa_int } \\
            \int_incr:N \l_tmpa_int
        }

        \ulinec[.28]{\l_@@_school_name_tl}学院
        \ulinec[.28]{\l_@@_major_tl}~专业类~\ulinec[.15]{\l_@@_class_tl}班 \\
        学生\ulinec[.3]{\l_@@_author_tl} \\
        毕业设计(论文)时间：~~
        \ulinec[.1]{\l_@@_thesis_begin_year_tl}年
        \ulinec[.06]{\l_@@_thesis_begin_month_tl}月
        \ulinec[.06]{\l_@@_thesis_begin_day_tl}日
        至\ulinec[.1]{\l_@@_thesis_end_year_tl}年
        \ulinec[.06]{\l_@@_thesis_end_month_tl}月
        \ulinec[.06]{\l_@@_thesis_end_day_tl}日 \\
        答辩时间：
        \ulinec[.16]{\l_@@_defense_year_tl}年
        \ulinec[.08]{\l_@@_defense_month_tl}月
        \ulinec[.08]{\l_@@_defense_day_tl}日 \\
        成\qquad 绩：\ulinec[.3]{} \\
        指导教师：\ulinec[.3]{} \\
        兼职教师或答疑教师（并指出所负责部分）：\\
        \ulinel{} \\
        \ulinel{} \\
        \ulinec[.28]{}系（教研室） 主任（签字）：\ulinec[.28]{} \\
        \vfill
        注：任务书应该附在已完成的毕业设计（论文）的首页。
        \end{spacing}
    }
    \parindent=2\ccwd
    \linespread{1.5}
}

%%%%%%%%%% nominate %%%%%%%%%%
% 研究生提名页
\cs_new:Nn \@@_cs_graduate_title_page: {
    \@@_cs_clear_page_ensure_even: \thispagestyle{empty}
    \begin{flushleft}
        {
            \zihao{5}\heiti\bfseries
            中图分类号：\l_@@_clc_number_tl \\
            论\,\,文\,\,编\,\,号：\l_@@_thesis_id_tl \\
        }
    \end{flushleft}

    \begin{center}
        \vskip 130bp
        { \zihao{-2} \heiti { \ziju{1.3} \l_@@_degree_long_tl 论文 } }
        \vskip 120bp
        \begin{minipage}[h]{.85\textwidth}
            \zihao{-1} \heiti
            \centering{ \l_@@_thesis_title_tl }
        \end{minipage}
        \vskip 130bp

        \begin{spacing}{2.2}
            { \zihao{-4} \songti
            \begin{tabular}[b]{llll}
                \makebox[6em][s]{作者姓名\hfill} & \l_@@_author_tl
                & 申请学位级别 & \l_@@_applied_degree_tl 
                \\
                指导教师姓名 
                & \makebox[9em][s]{
                    \l_@@_teacher_tl \quad \l_@@_teacher_two_tl \hfill
                } 
                & 职\qquad 称 & \l_@@_teacher_title_tl 
                \\
                \bool_if:NTF \g_@@_professional_bool {
                    \makebox[6em][s]{专业名称\hfill}
                } {
                    \makebox[6em][s]{学科专业\hfill}
                } & \l_@@_major_tl
                & \makebox[6em][s]{研究方向\hfill} & \l_@@_direction_tl 
                \\
                \makebox[6em][s]{学习时间自\hfill} 
                & \l_@@_thesis_begin_year_tl \hspace{0.5em} 年 \hspace{0.5em}
                \l_@@_thesis_begin_month_tl \hspace{0.5em} 月 \hspace{0.5em}
                \l_@@_thesis_begin_day_tl \hspace{0.5em} 日 \qquad 
                & \makebox[6em][s]{\hfill 起至\hfill} 
                & \l_@@_thesis_end_year_tl \hspace{0.5em} 年 \hspace{0.5em}
                \l_@@_thesis_end_month_tl \hspace{0.5em} 月 \hspace{0.5em}
                \l_@@_thesis_end_day_tl \hspace{0.5em} 日止 \qquad
                \\
                论文提交日期 
                & \l_@@_submission_year_tl \hspace{0.5em} 年 \hspace{0.5em}
                \l_@@_submission_month_tl \hspace{0.5em} 月 \hspace{0.5em}
                \l_@@_submission_day_tl \hspace{0.5em} 日 \qquad 
                & 论文答辩日期
                & \l_@@_defense_year_tl \hspace{0.5em} 年 \hspace{0.5em}
                \l_@@_defense_month_tl \hspace{0.5em} 月 \hspace{0.5em}
                \l_@@_defense_day_tl \hspace{0.5em} 日 \qquad
                \\
                学位授予单位 
                & \l_@@_university_name_tl
                & 学位授予日期 
                & \l_@@_award_year_tl \hspace{0.5em} 年 \hspace{0.5em}
                \l_@@_award_month_tl \hspace{0.5em} 月 \hspace{0.5em}
                \l_@@_award_day_tl \hspace{0.5em} 日 \qquad
                \\
            \end{tabular}}
        \end{spacing}
    \end{center}
}

%%%%%%%%%% creation and use %%%%%%%%%%
% 研究生独创性声明和授权书

\cs_new:Nn \@@_cs_graduate_declaration_page: {
    \@@_cs_clear_page_ensure_even: \thispagestyle{empty}
    \vspace*{50bp}
    \centerline{\zihao{3}\heiti 关于学位论文的独创性声明}
    \zihao{-4}\songti
    ~~\par
        本人郑重声明：所呈交的论文是本人在指导教师指导下独立进行研究工作所取得的成果，
    论文中有关资料和数据是实事求是的。尽我所知，除文中已经加以标注和致谢外，
    本论文不包含其他人已经发表或撰写的研究成果，也不包含本人或他人为获得北京航空航天大学
    或其它教育机构的学位或学历证书而使用过的材料。与我一同工作的同志对研究所做的任何贡献
    均已在论文中作出了明确的说明。\par
    若有不实之处，本人愿意承担相关法律责任。\par
    ~~\par
    {\zihao{5}\ 学位论文作者签名：\uline{\mbox{\hspace{7em}}}\hspace{5em}日期：\hspace{7ex}年\hspace{5ex}月\hspace{5ex}日}
    \vskip 130bp
    \centerline{\zihao{3}\heiti 学位论文使用授权书}
    ~~\par
        本人完全同意北京航空航天大学有权使用本学位论文（包括但不限于其印刷版和电子版），
    使用方式包括但不限于：保留学位论文，按规定向国家有关部门（机构）送交学位论文，
    以学术交流为目的赠送和交换学位论文，允许学位论文被查阅、借阅和复印，将学位论文的全部
    或部分内容编入有关数据库进行检索，采用影印、缩印或其他复制手段保存学位论文。\par
    保密学位论文在解密后的使用授权同上。\par
    ~~\par
    {\zihao{5}
    \ 学位论文作者签名：\uline{\mbox{\hspace{7em}}}\hspace{5em}日期：\hspace{7ex}年\hspace{5ex}月\hspace{5ex}日\par
    \ 指导教师签名：\uline{\mbox{\hspace{9em}}}\hspace{5em}日期：\hspace{7ex}年\hspace{5ex}月\hspace{5ex}日}
}

%%%%%%%%%% denotation %%%%%%%%%%
% 符号对照表

\NewDocumentEnvironment{denotation}{}
{
    \chapter*{主要符号对照表\markboth{主要符号对照表}{}} % no tocline
    \begin{list}{}
    {
        \zihao{-4}
        \renewcommand\makelabel[1]{##1\hfil}
        \setlength{\labelwidth}{2.5cm} % 标签盒子宽度
        \setlength{\labelsep}{0.5cm} % 标签与列表文本距离
        \setlength{\itemindent}{0cm} % 标签缩进量
        \setlength{\leftmargin}{10em} % 左边界
        \setlength{\rightmargin}{0cm}
        \setlength{\parsep}{0cm} % 段落间距
        \setlength{\itemsep}{0cm} % 标签间距
        \setlength{\listparindent}{0cm} % 段落缩进量
        \setlength{\topsep}{0cm} % 标签与上文的间距
    }
}
{\end{list}}

%%%%%%%%%% settings for custom pages %%%%%%%%%%
% 首页重定义

\RenewDocumentCommand{\maketitle}{}{
    \@@_cs_cover_page:
    \bool_case:n {
        { \g_@@_bachelor_bool && \g_@@_proposal_bool } { \pagestyle{fancy} \frontmatter }
        { \g_@@_bachelor_bool } {
            \pagestyle{empty}
            \loadgeometry{bachelortaskgeometry}
            \@@_cs_bachelor_assignment_page:
            \loadgeometry{bachelorgeometry}
            \@@_cs_bachelor_declaration_page:                 %本科生声明
            \pagestyle{fancy}
            \frontmatter
        }
        { (\g_@@_master_bool || \g_@@_doctor_bool) && \g_@@_proposal_bool } { \@@_cs_clear_page_ensure_even: \frontmatter }
        { \g_@@_master_bool || \g_@@_doctor_bool } {
            \@@_cs_graduate_cover_page_eng:             %研究生英文封面
            \@@_cs_graduate_title_page:                 %研究生题名页
            \@@_cs_graduate_declaration_page:           %研究生独创性声明和使用授权书
            \@@_cs_clear_page_ensure_even:
            \frontmatter
        }
    }
    \songti
    \zihao{-4}
}

%%%%% 'buaathesis.cls' %%%%% END
