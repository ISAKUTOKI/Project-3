using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// 定义卡牌可能产生的效果
/// </summary>
public interface IEffect
{
    public void Resolve();
}
