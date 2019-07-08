package com.hsun.ywork.tools;

/**
 * Created by Administrator on 2017-09-07 .
 */
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

/**
 * 用于增量发布程序，只拷贝svn修改过的java文件对应的class文件
 */
public class ClassSvn
{
    static int count =0;
    private static String javaPath = "D:\\update\\ywork-svn\\src\\main\\java";
    private static String classPath = "F:\\sanbo\\work\\1products\\hxfy\\ywork-web\\src\\main\\webapp\\WEB-INF\\classes";


    public static void main(String[] args)
    {
        File f1 = new File(javaPath);
        File f2 = new File(classPath);
        if(f1.exists() && f2.exists())
        {
            createPath(f1);
        }
        System.out.println("共复制了"+count+"个class文件");
    }

    /*
     *  根据java文件找到对应的class文件，并将lclass文件复制到对应目录下，同时删除java文件
     */
    public  static void createPath(File file)
    {
        if(file.exists())
        {
            File[] files = file.listFiles();
            for(File f : files)
            {
                if(f.isDirectory())
                {//判断是否是目录
                    createPath(f);
                }
                else
                {
                    if(f.getName().endsWith(".java"))
                    {
                        //去掉扩展名之后的文件名
                        final String temp = f.getName().substring(0, f.getName().indexOf(".java"));

                        //class 所在文件夹
                        final String path = classPath + f.getPath().substring(javaPath.length(), f.getPath().lastIndexOf("\\")+1);
                        File[] filels = new File(path).listFiles();//获取文件夹下的所有文件
                        for(int i=0;i<filels.length;i++)
                        {
                            if(filels[i].isFile())
                            {
                                if(filels[i].getName().indexOf(temp) != -1)//将带$的class也copy出来
                                {
                                    count++;
                                    File classfile = new File(path+filels[i].getName());
                                    File javafile = new File(f.getPath().substring(0,f.getPath().lastIndexOf("\\")+1)+filels[i].getName());
                                    try
                                    {
                                        copyFile(classfile,javafile);
                                        f.delete();
                                    }
                                    catch (Exception e)
                                    {
                                        e.printStackTrace();
                                    }
                                    System.out.println(filels[i].getName());
                                }
                            }
                        }
                    }
                }
            }
        }
    }


    /**
     * 将F1复制到F2
     *
     */
    public static void copyFile(File f1, File f2) throws Exception
    {
        int length = 2097152;
        FileInputStream in = new FileInputStream(f1);
        FileOutputStream out = new FileOutputStream(f2);
        byte[] buffer = new byte[length];

        int len = 0;
        while ((len = in.read(buffer)) != -1)
        {
            out.write(buffer, 0, len);
        }
        in.close();
        out.flush();
        out.close();
    }
}
