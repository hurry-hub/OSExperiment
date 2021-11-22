
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                               clock.c
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                                                    Forrest Yu, 2005
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

#include "type.h"
#include "const.h"
#include "protect.h"
#include "proto.h"
#include "string.h"
#include "proc.h"
#include "global.h"


/*======================================================================*
                           clock_handler
 *======================================================================*/
PUBLIC void clock_handler(int irq)
{
	/*ticks++;
	p_proc_ready->ticks--;

	if (k_reenter != 0) {
		return;
	}

	if (p_proc_ready->ticks > 0) {
		return;
	}*/

	if (flag == 1) {			//判断是否是第一次进入到时钟中断
	    flag = 0;
		temp = 0;				//设置进程首次到达的标志
		return; 
	}	

	ticks++;										//系统时钟
	

	PROCESS *p;
	for (p = proc_table; p < proc_table + NR_TASKS; p++) {
		if (ticks == p->arrive_time) {
			switch (p->pid)									//初始化优先级和运行时间
			{
			case 0:
				p->ticks  = p->priority = 20;
				disp_color_str(p->p_name, BRIGHT | MAKE_COLOR(BLACK, GREEN));
				disp_color_str(" arrive! ", BRIGHT | MAKE_COLOR(BLACK, GREEN));
				break;
			case 1:
				p->ticks = p->priority = 18;
				disp_color_str(p->p_name, BRIGHT | MAKE_COLOR(BLACK, GREEN));
				disp_color_str(" arrive! ", BRIGHT | MAKE_COLOR(BLACK, GREEN));
				break;
			case 2:
				p->ticks = p->priority = 16;
				disp_color_str(p->p_name, BRIGHT | MAKE_COLOR(BLACK, GREEN));
				disp_color_str(" arrive! ", BRIGHT | MAKE_COLOR(BLACK, GREEN));
				break;
			case 3:
				p->ticks = p->priority = 14;
				disp_color_str(p->p_name, BRIGHT | MAKE_COLOR(BLACK, GREEN));
				disp_color_str(" arrive! ", BRIGHT | MAKE_COLOR(BLACK, GREEN));
				break;
			case 4:
				p->ticks = p->priority = 12;
				disp_color_str(p->p_name, BRIGHT | MAKE_COLOR(BLACK, GREEN));
				disp_color_str(" arrive! ", BRIGHT | MAKE_COLOR(BLACK, GREEN));
				break;
			case 5:
				p->ticks = p->priority = 10;
				disp_color_str(p->p_name, BRIGHT | MAKE_COLOR(BLACK, GREEN));
				disp_color_str(" arrive! ", BRIGHT | MAKE_COLOR(BLACK, GREEN));
				break;
			}
			p->queue = 1;									//初始化各进程于队列一
			p->remained_time = QUEUE_ONE_TIME;				//初始化进程时间片为队列一时间片
			p->arrive = 1;									//设置进程已经到达
			p->status = READY;								//设置进程为就绪态
			if (temp == 0) {
				p_proc_ready = p;							//最先到达的进程的标志
				//disp_str(p_proc_ready->p_name);
			}
			temp = 1;
		}		
	}
	if (temp == 1) {
		p_proc_ready->ticks--;							//程序剩余时间
		p_proc_ready->remained_time--;					//该队列中程序剩余时间片

		if (p_proc_ready->ticks < 1) {
			p_proc_ready->queue = 3;							//设置运行完的进程在队列三以方便处理
			p_proc_ready->remained_time = 0;					//运行时间片清零
		}
		if (p_proc_ready->remained_time != 0) {					//未运行完当前时间片直接返回
			return;
		}
		if (p_proc_ready->queue == 1) {							//切换队列并重新分配时间片
			p_proc_ready->remained_time = QUEUE_TWO_TIME;
			p_proc_ready->queue = 2;
		} else if (p_proc_ready->queue == 2) {
			p_proc_ready->remained_time = QUEUE_THREE_TIME;
			p_proc_ready->queue = 3;
		} else if (p_proc_ready->queue == 3 && p_proc_ready->ticks >= 1) {
			p_proc_ready->remained_time = QUEUE_THREE_TIME;
		}

		schedule();												//使用多级反馈队列调度算法
		if (k_reenter != 0) {									//判断中断重入
			return;
		}
	}
}

/*======================================================================*
                              milli_delay
 *======================================================================*/
PUBLIC void milli_delay(int milli_sec)
{
        int t = get_ticks();

        while(((get_ticks() - t) * 1000 / HZ) < milli_sec) {}
}

